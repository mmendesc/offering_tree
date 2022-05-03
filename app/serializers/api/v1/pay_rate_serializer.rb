# frozen_string_literal: true

module Api
  module V1
    class PayRateSerializer < ApplicationSerializer
      attributes :rate_name_char, :base_rate_per_client, :min_client_count,
                 :max_client_count, :rate_per_client
    end
  end
end
