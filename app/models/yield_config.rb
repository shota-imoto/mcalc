class YieldConfig < ApplicationRecord
  belongs_to :user

  attr_accessor :monthly_yield
  after_find :set_monthly_yield

  validates :annual_yield, presence: true

  def self.find_by_user_or_initialize(params)
    yield_config = find_or_initialize_by(user: params[:user])
    yield_config.assign_attributes(params)
    yield_config
  end

  def set_monthly_yield
    self.monthly_yield = monthly_yield_calc
  end

  private

  def monthly_yield_calc
    yield_after_a_year = (1 + annual_yield.to_r * 0.01)
    yield_after_a_year ** (1.0/12)
  end
end
