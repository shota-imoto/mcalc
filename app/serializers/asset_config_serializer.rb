class AssetConfigSerializer
  include JSONAPI::Serializer

  attributes :monthly_purchase, :annual_yield
end
