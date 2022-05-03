# frozen_string_literal: true

module Api
  module V1
    class AmountSerializer < ApplicationSerializer
      attributes :amount, :clients
    end
  end
end
