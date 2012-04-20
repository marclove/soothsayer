# Soothsayer
Soothsayer is a thin Ruby wrapper around Google's Prediction API.

## Setup
Go to [Google's API Console](http://code.google.com/apis/console). Sign up and turn on both the "Google Cloud Storage" and "Prediction API" services. Before you can use the Prediction API, you'll have to turn on billing.

Go to "API Access" section of the Google API Console and create a "Client ID for installed applications." You'll need the "Client ID" and "Client secret."

Download Google's Ruby API client gem:
    gem install google-api-client

Now you need to download your OAuth keys
    google-api oauth-2-login --scope=https://www.googleapis.com/auth/prediction --client-id=<< YOUR CLIENT ID >> --client-secret=<< YOUR CLIENT SECRET >>

This will create a file at <code>~/.google-api.yaml</code> which contains your OAuth keys. Move this file into your project and use it to configure Soothsayer:
    config_file = File.expand_path('path/to/google-api.yaml')
    config = open(config_file, 'r'){ |file| YAML.load(file.read) }
    Soothsayer.config do |c|
      c.client_id = config.client_id
      c.client_secret = config.client_secret
      c.access_token = config.access_token
      c.refresh_token = config.refresh_token
    end

## Usage
To use Soothsayer, refer to [Google's documentation](https://developers.google.com/prediction/docs/reference/v1.5/reference).

    SoothSayer::HostedModel.predict("sample.languageid", {:input => {:csvInstance => ["Como se llama?"]}})
    SoothSayer::TrainedModel.list
    SoothSayer::TrainedModel.update("my.trained.model.name", {:label => "my_label", :csvInstance => [col1, col2, col3]})