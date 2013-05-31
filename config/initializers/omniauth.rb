Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, APP_CONFIG["twitter_id"], APP_CONFIG['twitter_secret']
  provider :facebook, APP_CONFIG["facebook_id"], APP_CONFIG['facebook_secret'],
           :image_size => "large", :scope => "email"
  provider :google, APP_CONFIG["google_id"], APP_CONFIG['google_secret']
end