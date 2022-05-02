# frozen_string_literal: true

module PayRates
  class Update < Base
    def call(pay_rate, params)
      @pay_rate = pay_rate
      @params = params

      sanitize_pay_rate_bonus_attributes

      update_pay_rate
    end

    private

    attr_reader :params, :pay_rate

    def update_pay_rate
      pay_rate.update!(params)
    end
  end
end
