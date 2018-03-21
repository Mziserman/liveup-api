class Api::V1::UserSerializer < ActiveModel::Serializer

  attributes :id,
             :email,
             :stream_id
             :first_name,
             :last_name,
             :pseudo,
             :slug
             
  attribute :auth_token, if: -> { instance_options[:auth_token].present? }

  def auth_token
    instance_options[:auth_token]
  end

  attribute :refresh_token, if: -> { instance_options[:refresh_token].present? }

  def refresh_token
    instance_options[:refresh_token]
  end

  def stream_id
    @object&.streams&.last&.id
  end

end
