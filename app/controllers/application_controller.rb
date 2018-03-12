class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  def authenticate_request!
    if !user_id_in_token? && !expired(auth_token)
      raise UnauthorizedError
    end

    @current_user = User.find(auth_token[:user_id])
  end

  protected

  private

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id]
  end

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    else

    end
  end

  def auth_token
    @auth_token ||= ::JsonWebToken.decode(http_token)
  end

  def expired(payload)
    payload[:exp].present? && Time.at(payload[:exp]) > Time.now
  end

  # def set_raven_context
  #   Raven.user_context(id: session[:current_user_id]) # or anything else in session
  #   Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  # end
end
