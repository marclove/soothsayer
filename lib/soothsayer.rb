require "soothsayer/version"
require "soothsayer/hosted_model"
require "soothsayer/trained_model"
require 'httparty'
require 'google/api_client'
require 'json'

module Soothsayer
  def self.credentials
    @@config
  end

  # Configures Soothsayer with the credentials downloaded by the Ruby api client into .google-api.yaml
  #
  #   config_file = File.expand_path('~/.google-api.yaml')
  #   config = open(config_file, 'r'){ |file| YAML.load(file.read) }
  #   Soothsayer.config do |c|
  #     c.client_id = config.client_id
  #     c.client_secret = config.client_secret
  #     c.access_token = config.access_token
  #     c.refresh_token = config.refresh_token
  #   end
  #
  def self.config(config = Configuration.new)
    yield config
    @@config = config
  end

  class Configuration
    attr_accessor :client_id, :client_secret, :access_token, :refresh_token
  end

  class OAuthTokenError < StandardError; end
  class API
    include HTTParty
    format :json
    base_uri 'https://www.googleapis.com/prediction/v1.6/projects'
    debug_output $stderr

    class << self
      attr_accessor :api_client, :project_id

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
        raise OAuthTokenError, 'Please configure Soothsayer first with Soothsayer.config.' if Soothsayer.credentials.nil?
        client = Google::APIClient.new(:authorization => :oauth_2)
        unless client.authorization.nil?
          client.authorization.scope = nil
          client.authorization.client_id = Soothsayer.credentials.client_id
          client.authorization.client_secret = Soothsayer.credentials.client_secret
          client.authorization.access_token = Soothsayer.credentials.access_token
          client.authorization.refresh_token = Soothsayer.credentials.refresh_token
          client.register_discovery_uri('discovery', 'v1.5', nil)
          self.api_client = client
        else
          raise OAuthTokenError
        end
      end
    end
  end
end
