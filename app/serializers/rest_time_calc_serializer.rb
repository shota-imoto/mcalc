class RestTimeCalcSerializer
  include JSONAPI::Serializer

  set_id :user_id
  attributes :asset_years
  attributes :messages do |rest_time_calc|
    rest_time_calc.errors.messages
  end

  belongs_to :user, serializer: UserSerializer
end
