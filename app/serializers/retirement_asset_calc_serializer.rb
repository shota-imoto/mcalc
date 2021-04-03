class RetirementAssetCalcSerializer
  include JSONAPI::Serializer

  attributes :monthly_living_cost, :four_percents_rule_ajustment
end
