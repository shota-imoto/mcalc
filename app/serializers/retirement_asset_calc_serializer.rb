class RetirementAssetCalcSerializer
  include JSONAPI::Serializer

  attributes :monthly_living_cost, :tax_rate, :annual_yield
end
