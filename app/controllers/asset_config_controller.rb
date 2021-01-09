class AssetConfigController < ApplicationController
  def new
    @asset_config = AssetConfig.new
  end

  def create
    binding.pry
    @asset_config = AssetConfig.new(asset_config_params)
    if @asset_config.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @asset_config = AssetConfig.last
  end

  def update
    @asset_config = AssetConfig.last
    if @asset_config.update(asset_config_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def asset_config_params
    params.require(:asset_config).permit!.merge(user_id: current_user.id)
  end
end
