class RestTimeCalcSerializer
  include JSONAPI::Serializer

  set_id :user_id
  attributes :retire_day, :rest_days
  attributes :messages do |rest_time_calc|
    rest_time_calc.valid?
    rest_time_calc.errors.messages
  end

  belongs_to :user, serializer: UserSerializer
end
