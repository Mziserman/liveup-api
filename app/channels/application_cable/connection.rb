module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      if request.params[:auth_token].blank?
        self.current_user = nil
      elsif !user_id_in_auth_token? || expired(@auth_token)
        reject_unauthorized_connection
      else
        self.current_user = User.find(@auth_token[:user_id])
      end

    end

    private

    def user_id_in_auth_token?
      decode_auth_token && @auth_token[:user_id].present?
    end

    def decode_auth_token
      @auth_token ||= ::JsonWebToken.decode(request.params[:auth_token])
    end

    def expired(payload)
      payload[:exp].present? && Time.at(payload[:exp]) < Time.now
    end
  end
end
