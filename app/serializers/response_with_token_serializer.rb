class ResponseWithTokenSerializer
  include JSONAPI::Serializer

  set_id :user_id
  attributes :status, :message, :token
end
