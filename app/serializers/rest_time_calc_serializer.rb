class RestTimeCalcSerializer
  include JSONAPI::Serializer

  set_id :user_id
  attributes :asset_years

  belongs_to :user, serializer: UserSerializer
end
