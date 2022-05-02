# frozen_string_literal: true

module PayRates
  class Create < Base
    def call(params)
      @params = params

      sanitize_pay_rate_bonus_attributes

      create_pay_rate
    end

    private

    attr_reader :params

    def create_pay_rate
      PayRate.create!(params)
    end
  end
end
