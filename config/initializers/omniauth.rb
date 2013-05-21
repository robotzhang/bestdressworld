Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, 'wfv1ezxG7IfnBxPR87S0wg', '0t6g3Svs2FLktHZ3yEcywUVzFzz6ufJxGR60uHMUaY'
end