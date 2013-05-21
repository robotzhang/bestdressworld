Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, 'wfv1ezxG7IfnBxPR87S0wg', '0t6g3Svs2FLktHZ3yEcywUVzFzz6ufJxGR60uHMUaY'
  provider :facebook, '371470182974626', '5eadc2802d9f814d1d6d7af2b6239baa'
  provider :google, '79816562973.apps.googleusercontent.com', '_QUXnZWXfB59AFTFfydAxbnt'
end