class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  def authenticate_request!
    if !user_id_in_auth_token? || expired(auth_token)
      return head :unauthorized
    end

    @current_user = User.find(auth_token[:user_id])
  end

  def reconnect_user!
    if !user_id_in_refresh_token?
      return head :unauthorized
    end

    user = User.find(refresh_token[:user_id])

    if user.refresh_token != http_refresh_token
      return head :unauthorized
    else
      @current_user = user
    end
  end

  private

  def user_id_in_auth_token?
    http_auth_token && auth_token && auth_token[:user_id].present?
  end

  def http_auth_token
    if request.headers['Authorization'].present?
      @http_token ||= request.headers['Authorization'].split(' ').last
    else
      false
    end
  end

  def auth_token
    @auth_token ||= ::JsonWebToken.decode(http_auth_token)
  end

  def user_id_in_refresh_token?
    http_refresh_token && refresh_token && refresh_token[:user_id]
  end

  def http_refresh_token
    if request.headers['Refresh'].present?
      @http_refresh_token ||= request.headers['Refresh'].split(' ').last
    else
      false
    end
  end

  def refresh_token
    @refresh_token ||= ::JsonWebToken.decode(http_refresh_token)
  end

  def expired(payload)
    payload[:exp].present? && Time.at(payload[:exp]) < Time.now
  end

  # def set_raven_context
  #   Raven.user_context(id: session[:current_user_id]) # or anything else in session
  #   Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  # end
end
