class Api::V1::WebhooksController < ApplicationController

  def webhook

    render json: {"coucou": true}
  end

end