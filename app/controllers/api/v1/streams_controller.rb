class Api::V1::StreamsController < ApplicationController
  before_action :authenticate_request!, except: [:index, :show]
  before_action :set_stream, only: [:show, :edit, :update, :destroy, :follow, :upvoted_questions]
  # before_action :authorize_user!, except: [:index, :create, :show, :follow, :upvoted_questions]

  Stripe.api_key = ENV["stripe_api"]

  api :GET, '/v1/streams', 'List streams'
  def index
    @streams = Stream.all
    render json: @streams,
      status: :ok
  end

  api :POST, '/v1/streams', 'Create stream'
  def create
    opentok = OpenTok::OpenTok.new ENV["tokbox_api_key"], ENV["tokbox_api_secret"]
    session = opentok.create_session
    token = session.generate_token


    @stream = @current_user.channel&.streams&.new(session_id: session.session_id, token: token)
    if @stream.save
      render json: @stream,
        status: :created
    else
      render json: @stream.errors,
        status: :bad_request
    end
  end

  api :GET, '/v1/streams/:id', 'Show stream'
  param :id, String, 'Stream id'
  def show
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

  api :POST, '/v1/streams/:stream_id/buy', 'One shot stream buying'
  param :stripeToken, String, 'Stripe id provided by stripe payment module. Checkout it out m8 => https://github.com/stripe/react-stripe-elements !'
  def buy

    customer = User.checkCustomer(@current_user)

    if !customer
      render json: {'error': 'customer does not exist. You should consider creating it by using this => /api/v1/customers POST#CREATE. Have a nice day !'}
      return
    end

    product = StripeProduct.where(product_type: 'one_shot').first

    @current_user.streams << @stream

    @charge = Stripe::Charge.create({
      amount: product.price,
      currency: 'eur',
      description: 'Buy stream ' + params[:stream_id],
      source: params[:stripeToken],
    })

    if @current_user.save
      render json: @charge,
        status: :ok
    end
  end

  private

  def stream_params
    params.require(:stream).permit(
      :channel_id,
      :live)
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
