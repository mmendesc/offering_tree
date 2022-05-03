# frozen_string_literal: true

class PayRatesController < ApplicationController
  rescue_from(
    ActiveRecord::RecordInvalid,
    ActiveRecord::NotNullViolation
  ) do |exception|
    render_errors(:unprocessable_entity, exception)
  end

  def create
    PayRates::Create.new.call(pay_rate_params)

    head :created
  end

  def update
    PayRates::Update.new.call(pay_rate, pay_rate_params)

    head :ok
  end

  def pay_amount
    amount = PayRates::CalculatePayAmount.new.call(pay_rate, params[:clients].to_i)

    render json: { amount: amount }
  end

  private

  def pay_rate
    PayRate.find(pay_rate_id)
  end

  def pay_rate_id
    params.require(:id)
  end

  def pay_rate_params
    params.require(:pay_rate).permit(
      :rate_name_char,
      :base_rate_per_client,
      pay_rate_bonus_attributes: %i[
        id
        rate_per_client
        min_client_count
        max_client_count
      ]
    )
  end
end
