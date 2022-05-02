# frozen_string_literal: true

FactoryBot.define do
  factory :pay_rate_bonus do
    association :pay_rate

    rate_per_client { 3.0 }
    min_client_count { 25 }
  end
end
