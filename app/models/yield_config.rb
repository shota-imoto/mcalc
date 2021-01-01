class YieldConfig < ApplicationRecord
  belongs_to :user

  attr_accessor :monthly_yield
  after_find :set_monthly_yield

  def set_monthly_yield
    self.monthly_yield = monthly_yield_calc
  end

  private

  def monthly_yield_calc
    yield_after_a_year = (1 + annual_yield.to_r * 0.01)
    yield_after_a_year ** (1.0/12)
  end
end
