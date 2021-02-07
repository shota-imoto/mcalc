class AssetConfigSerializer
  include JSONAPI::Serializer

  attributes :initial_asset, :monthly_purchase, :annual_yield
end
