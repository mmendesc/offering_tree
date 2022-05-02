# frozen_string_literal: true

module PayRates
  class CalculatePayAmount
    def call(pay_rate, num_clients)
      @num_clients = num_clients
      @pay_rate = pay_rate

      base_amount + bonus_amount
    end

    private

    attr_reader :num_clients, :pay_rate

    def base_amount
      pay_rate.base_rate_per_client * num_clients
    end

    def bonus_amount
      return 0 unless pay_rate_bonus
      return 0 if min_clients && num_clients < min_clients
      return (max_clients - min_clients) * pay_rate_bonus.rate_per_client if max_clients && num_clients > max_clients

      (num_clients - min_clients) * pay_rate_bonus.rate_per_client
    end

    def pay_rate_bonus
      @pay_rate_bonus ||= pay_rate.pay_rate_bonus
    end

    def min_clients
      pay_rate_bonus.min_client_count
    end

    def max_clients
      pay_rate_bonus.max_client_count
    end
  end
end
