module Soothsayer
  class HostedModel
    class << self
      def predict(hosted_model_name, params)
        API.post("/hostedmodels/#{hosted_model_name}/predict", opts(params))
      end

      private
        def opts(params=nil)
          options = {
            :headers => {
              "Authorization" => "Bearer #{API.oauth_token}",
              "Content-Type" => "application/json"
            }
          }
          options[:body] = MultiJson.dump(params) unless params.nil?
          options
        end
    end
  end
end
