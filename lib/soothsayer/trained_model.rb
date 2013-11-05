module Soothsayer
  class TrainedModel
    class << self
      def list
        API.get("/#{API.project_id}/trainedmodels/list", opts).parsed_response
      end

      def get(model_id)
        API.get("/#{API.project_id}/trainedmodels/#{model_id}", opts).parsed_response
      end

      def insert(params)
        API.post("/#{API.project_id}/trainedmodels", opts(params)).parsed_response
      end

      def update(model_id, params)
        API.put("/#{API.project_id}/trainedmodels/#{model_id}", opts(params)).parsed_response
      end

      def delete(model_id)
        API.delete("/#{API.project_id}/trainedmodels/#{model_id}", opts).parsed_response
      end

      def predict(model_id, params)
        API.post("/#{API.project_id}/trainedmodels/#{model_id}/predict", opts(params)).parsed_response
      end

      def analyze(model_id)
        API.get("/#{API.project_id}/trainedmodels/#{id}/analyze", opts).parsed_response
      end

      private
        def opts(params=nil)
          options = {
            :headers => {
              "Authorization" => "Bearer #{API.oauth_token}",
              "Content-Type" => "application/json"
            }
          }
          options[:body] = JSON.dump(params) unless params.nil?
          options
        end
    end
  end
end
