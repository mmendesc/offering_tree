# frozen_string_literal: true

FactoryBot.define do
  factory :pay_rate do
    sequence(:rate_name_char) { |i| "Rate Name #{i}" }
    base_rate_per_client { 5.0 }
  end
end
