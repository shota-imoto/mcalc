class ResponseSerializer
  include JSONAPI::Serializer

  set_id :user_id
  attributes :status, :message
end
