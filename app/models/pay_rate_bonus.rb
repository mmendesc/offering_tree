# frozen_string_literal: true

class PayRateBonus < ApplicationRecord
  self.table_name = 'pay_rate_bonuses'

  belongs_to :pay_rate
end