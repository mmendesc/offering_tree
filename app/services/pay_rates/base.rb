# frozen_string_literal: true

module PayRates
  class Base
    def sanitize_pay_rate_bonus_attributes
      if params[:pay_rate_bonus_attributes].blank?
        params.delete(:pay_rate_bonus_attributes)
      else
        validate_bonus(params[:pay_rate_bonus_attributes])
      end
    end

    def validate_bonus(attributes)
      return unless attributes
      return if attributes[:max_client_count] || attributes[:min_client_count]

      raise ActiveRecord::RecordInvalid
    end
  end
end
