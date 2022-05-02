# frozen_string_literal: true

class PayRate < ApplicationRecord
  has_one :pay_rate_bonus

  accepts_nested_attributes_for :pay_rate_bonus, update_only: true
end
