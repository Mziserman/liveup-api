require 'rails_helper'

RSpec.describe Api::V1::FollowsController, type: :routing do
  describe 'routing' do
    it 'routes to #index via GET' do
      expect(get: '/api/v1/follows').to route_to(
        format: 'json',
        controller: 'api/v1/follows',
        action: 'index'
      )
    end

    it 'routes to #create via POST' do
      expect(post: '/api/v1/channels/1/follows').to route_to(
        format: 'json',
        controller: 'api/v1/follows',
        action: 'create',
        channel_id: '1'
      )
    end

    it 'routes to #destroy via DELETE' do
      expect(delete: '/api/v1/channels/1/follows').to route_to(
        format: 'json',
        controller: 'api/v1/follows',
        action: 'destroy',
        channel_id: '1'
      )
    end
  end
end
