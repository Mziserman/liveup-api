require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #sign_in via POST' do
      expect(post: '/api/v1/users/sign_in').to route_to(
        format: 'json',
        controller: 'api/v1/users',
        action: 'sign_in'
      )
    end

    it 'routes to #reconnect via POST' do
      expect(post: '/api/v1/users/reconnect').to route_to(
        format: 'json',
        controller: 'api/v1/users',
        action: 'reconnect'
      )
    end

    it 'routes to #create via POST' do
      expect(post: '/api/v1/users').to route_to(
        format: 'json',
        controller: 'api/v1/users',
        action: 'create'
      )
    end

    it 'routes to #index via GET' do
      expect(get: '/api/v1/users').to route_to(
        format: 'json',
        controller: 'api/v1/users',
        action: 'index'
      )
    end

    it 'routes to #show via GET' do
      expect(get: '/api/v1/users/1').to route_to(
        format: 'json',
        controller: 'api/v1/users',
        action: 'show',
        id: '1'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/users/1').to route_to(
        format: 'json',
        controller: 'api/v1/users',
        action: 'update',
        id: '1'
      )
    end

    it 'routes to #destroy via DELETE' do
      expect(delete: '/api/v1/users/1').to route_to(
        format: 'json',
        controller: 'api/v1/users',
        action: 'destroy',
        id: '1'
      )
    end
  end
end
