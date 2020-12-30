class YieldConfigController < ApplicationController
  def new
    @yield_config = YieldConfig.new
  end

  def create
    @yield_config = YieldConfig.new(yield_config_params)
    if @yield_config.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @yield_config = YieldConfig.last
  end

  def update
    @yield_config = YieldConfig.last
    if @yield_config.update(yield_config_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def yield_config_params
    params.require(:yield_config).permit!
  end
end
