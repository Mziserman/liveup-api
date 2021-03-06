class Api::V1::StreamSerializer < ActiveModel::Serializer

  attributes :id,
             :title,
             :description,
             :channel_id,
             :session_id,
             :view_count,
             :total_view_count,
             :rediffusion_view_count,
             :token,
             :likes,
             :live?,
             :archive_url,
             :output_stream_url,
             :input_stream_url,
             :state,
             :thumbnail,
             :category

  def likes
    @object.likes_count
  end

  def view_count
    @object.view_count
  end

end
