class Api::V1::StreamSerializer < ActiveModel::Serializer

  attributes :id,
             :user_id,
             :session_id,
             :created_at,
             :updated_at

end
