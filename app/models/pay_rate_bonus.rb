# frozen_string_literal: true

class PayRateBonus < ApplicationRecord
  self.table_name = 'pay_rate_bonuses'

  belongs_to :pay_rate
  validates_presence_of :rate_per_client
  validate :client_limit_set

  private

  def client_limit_set
    errors.add(:base, 'Must set min or max clients for bonus') if limit_not_set
  end

  def limit_not_set
    (min_client_count || max_client_count).nil?
  end
end
