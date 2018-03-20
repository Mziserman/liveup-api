class Api::V1::FollowSerializer < ActiveModel::Serializer

  attributes :id,
             :follower_id,
             :streamer_id,
             :created_at,
             :updated_at

end
