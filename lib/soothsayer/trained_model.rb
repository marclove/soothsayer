module Soothsayer
  class TrainedModel
    class << self
      def list
        API.get("/trainedmodels/list", opts)
      end

      def get(model_id)
        API.get("/trainedmodels/#{model_id}", opts)
      end

      def insert(params)
        API.post("/trainedmodels", opts(params))
      end

      def update(model_id, params)
        API.put("/trainedmodels/#{model_id}", opts(params))
      end

      def delete(model_id)
        API.delete("/trainedmodels/#{model_id}", opts)
      end

      def predict(model_id, params)
        API.post("/trainedmodels/#{model_id}/predict", opts(params))
      end

      def analyze(model_id)
        API.get("/trainedmodels/#{id}/analyze", opts)
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
