class RootController < ApplicationController
  def index
    @asset_config = AssetConfig.last
  end
end
