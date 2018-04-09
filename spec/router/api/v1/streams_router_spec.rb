require 'rails_helper'

RSpec.describe Api::V1::StreamsController, type: :routing do
  describe 'routing' do
    it 'routes to #index via GET' do
      expect(get: '/api/v1/streams').to route_to(
        format: 'json',
        controller: 'api/v1/streams',
        action: 'index'
      )
    end

    it 'routes to #create via POST' do
      expect(post: '/api/v1/streams').to route_to(
        format: 'json',
        controller: 'api/v1/streams',
        action: 'create'
      )
    end

    it 'routes to #show via GET' do
      expect(get: '/api/v1/streams/1').to route_to(
        format: 'json',
        controller: 'api/v1/streams',
        action: 'show',
        id: '1'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/streams/1').to route_to(
        format: 'json',
        controller: 'api/v1/streams',
        action: 'update',
        id: '1'
      )
    end

    it 'routes to #destroy via DELETE' do
      expect(delete: '/api/v1/streams/1').to route_to(
        format: 'json',
        controller: 'api/v1/streams',
        action: 'destroy',
        id: '1'
      )
    end
  end
end
