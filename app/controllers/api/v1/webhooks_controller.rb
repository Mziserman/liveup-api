class Api::V1::WebhooksController < ApplicationController

  def webhook

    puts 

    render json: {"coucou": true}
  end

end