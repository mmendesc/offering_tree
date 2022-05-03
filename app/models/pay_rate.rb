# frozen_string_literal: true

class PayRate < ApplicationRecord
  has_one :pay_rate_bonus

  accepts_nested_attributes_for :pay_rate_bonus, update_only: true

  validates :rate_name_char, presence: true, length: { maximum: 50 }

  delegate :min_client_count, :max_client_count, :rate_per_client, to: :pay_rate_bonus, allow_nil: true
end
