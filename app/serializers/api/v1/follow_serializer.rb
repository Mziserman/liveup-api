class Api::V1::FollowSerializer < ActiveModel::Serializer

  attributes :id,
             :follower_id,
             :channel_id

end
