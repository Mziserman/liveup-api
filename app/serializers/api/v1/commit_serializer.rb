class Api::V1::CommitSerializer < ActiveModel::Serializer

  attributes :id,
             :shared_file,
             :name,
             :path,
             :version,
             :created_at

  def shared_file
    ::Api::V1::SharedFileSerializer.new(@object.shared_file, scope: scope, root: false)
  end

end
