require 'rails_helper'
require 'securerandom'

RSpec.describe Api::V1::UsersController, type: :controller do

  context 'protected' do
    before do
      user = create(:user)
      request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id, exp: 2.hours.ago.to_i)}"
      get :index
    end
    it 'raises on obsolete_id' do
      subject { JSON.parse(response.body).with_indifferent_access }
      expect(response.status).to eq(401)
    end
  end

  context 'private' do
    before do
      get :index
    end
    it 'raises on no_token' do
      subject { JSON.parse(response.body).with_indifferent_access }
      expect(response.status).to eq(401)
    end
  end

  context 'normal' do
    before do
      user = create(:user)
      request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id, exp: 5.hours.from_now.to_i)}"
      get :index
    end
    it 'does not raise' do
      subject { JSON.parse(response.body).with_indifferent_access }
      expect(response.status).to eq(200)
    end
  end
end
