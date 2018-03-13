class Api::V1::FollowSerializer < ActiveModel::Serializer

  attributes :id,
             :user_id,
             :stream_id,
             :created_at,
             :updated_at

end
