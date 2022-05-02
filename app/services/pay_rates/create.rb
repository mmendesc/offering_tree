# frozen_string_literal: true

module PayRates
  class Create
    def call(params)
      @params = params

      validate_bonus(params[:pay_rate_bonus_attributes])
      create_pay_rate
    end

    private

    attr_reader :params

    def validate_bonus(attributes)
      return unless attributes
      return if attributes[:max_client_count] || attributes[:min_client_count]

      raise ActiveRecord::RecordInvalid
    end

    def create_pay_rate
      PayRate.create!(params)
    end
  end
end
