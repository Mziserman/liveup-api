class Api::V1::StreamSerializer < ActiveModel::Serializer

  attributes :id,
             :title,
             :description,
             :channel_id,
             :session_id,
             :view_count,
             :token,
             :likes,
             :live?,
             :archive,
             :output_stream_url,
             :input_stream_url,
             :state

  def likes
    @object.likes_count
  end

  def archive
    # if @object.archive_id
    #   opentok = OpenTok::OpenTok.new ENV["tokbox_api_key"], ENV["tokbox_api_secret"]
    #   archive = opentok.archives.find @object.archive_id
    #   archive.url
    # end
  end

end
