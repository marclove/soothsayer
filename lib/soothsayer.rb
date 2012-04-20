require "soothsayer/version"
require "soothsayer/hosted_model"
require "soothsayer/trained_model"
require 'httparty'
require 'google/api_client'
require 'multi_json'

module Soothsayer
  class OAuthTokenError < StandardError; end
  class API
    include HTTParty
    format :json
    base_uri 'https://www.googleapis.com/prediction/v1.5'

    class << self
      attr_accessor :api_client

      def oauth_token
        if api_client.nil?
          create_client
          api_client.authorization.fetch_access_token!
        elsif api_client.authorization.expired?
          api_client.authorization.fetch_access_token!
        end
        api_client.authorization.access_token
      end

      def create_client
        config_file = File.expand_path('~/.google-api.yaml')
        config = open(config_file, 'r'){ |file| YAML.load(file.read) }
        client = Google::APIClient.new(:authorization => :oauth_2)
        unless client.authorization.nil?
          client.authorization.scope = nil
          client.authorization.client_id = config["client_id"]
          client.authorization.client_secret = config["client_secret"]
          client.authorization.access_token = config["access_token"]
          client.authorization.refresh_token = config["refresh_token"]
          client.register_discovery_uri('discovery', 'v1.5', nil)
          self.api_client = client
        else
          raise OAuthTokenError
        end
      end
    end
  end
end
