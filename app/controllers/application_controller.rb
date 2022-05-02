class ApplicationController < ActionController::API
  def render_errors(status, exception)
    render json: { error: exception.message }, status: status
  end
end
