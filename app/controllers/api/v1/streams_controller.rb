class Api::V1::StreamsController < ApplicationController
  include AwsStreamingConcern
  before_action :authenticate_request!, except: [:index, :show]
  before_action :set_stream, only: [:show, :edit, :update, :destroy, :follow, :upvoted_questions]
  before_action :authorize_user!, except: [:index, :create, :show, :follow, :upvoted_questions, :state, :end_stream]

  api :GET, '/v1/streams', 'List streams'
  def index
    @streams = if params['channel_id'].present?
      Channel.find(params['channel_id']).streams
    else
      Stream.all
    end
    render json: @streams,
      status: :ok
  end

  api :POST, '/v1/streams', 'Create stream'
  def create
    channel = @current_user.channel

    if channel.channel_type == "tokbox"
      opentok = OpenTok::OpenTok.new ENV["tokbox_api_key"], ENV["tokbox_api_secret"]
      session = opentok.create_session media_mode: :routed, resolution: "1280x720"
      token = session.generate_token

      @stream = channel&.streams&.new(stream_params)
      if @stream
        @stream.session_id = session.session_id
        @stream.token = token
      end
      if @stream.save
        render json: @stream,
          status: :created
      else
        render json: @stream.errors,
          status: :bad_request
      end
    else
      if channel.aws_input_id && channel.aws_channel_id
        aws_stream_object = start_stream(@current_user.id, channel.aws_input_id, channel.aws_channel_id)
      else
        aws_stream_object = start_stream(@current_user.id)
      end

      @stream = channel&.streams&.new(stream_params)
      if channel && @stream
        @stream.output_stream_url = aws_stream_object[:output_stream_url]
        @stream.input_stream_url = aws_stream_object[:input_stream_url]
        channel.aws_channel_id = aws_stream_object[:channel_id]
        channel.aws_input_id = aws_stream_object[:input_id]
      end
      if @stream.save && channel.save
        render json: @stream,
          status: :created
      else
        render json: @stream.errors,
          status: :bad_request
      end
    end
  end

  api :GET, '/v1/streams/:id', 'Show stream'
  param :id, String, 'Stream id'
  def show
    @stream.update view_count: @stream.view_count + 1
    render json: @stream,
      status: :ok
  end

  api :PUT, '/v1/streams/:id', 'Update stream'
  param :id, String, 'Stream id'
  def update
    if @stream.update(stream_params)
      render json: @stream,
        status: :ok
    else
      render json: @stream.errors,
        status: :bad_request
    end
  end

  api :DELETE, '/v1/streams/:id', 'Delete stream'
  param :id, String, 'Stream id'
  def destroy
    @stream.destroy
    head :no_content
  end

  def state
    @stream = Stream.find(params["stream_id"])
    state = check_status_channel(@stream.channel.aws_channel_id)

    render json: {state: state}
  end

  def end_stream
    channel = @current_user.channel
    @stream = Stream.find(params["stream_id"])
    stop_stream(@current_user.id, @stream.channel.aws_input_id, @stream.channel.aws_channel_id)

    if @stream.update(state: :off)
      head :no_content
    end
  end

  private

  def stream_params
    params.require(:stream).permit(
      :channel_id,
      :state,
      :description,
      :title)
  end


  def set_stream
    @stream = Stream.find(params[:id])
  end

  def authorize_user!
    if @current_user != @stream.channel.streamer
      return head :unauthorized
    end
  end

end
