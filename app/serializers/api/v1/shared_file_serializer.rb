class Api::V1::SharedFileSerializer < ActiveModel::Serializer

  attributes :id,
             :name,
             :path,
             :stream_id

end
