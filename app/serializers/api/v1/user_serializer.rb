class Api::V1::UserSerializer < ActiveModel::Serializer

  attributes :id,
             :email,
             # :first_name,
             # :last_name,
             :created_at,
             :updated_at

  attribute :token, if: -> { instance_options[:token].present? }

  def token
    instance_options[:token]
  end

end
