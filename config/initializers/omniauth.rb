Rails.application.config.middleware.use OmniAuth::Builder do
  provider :patreon,
           Rails.application.credentials.dig(:patreon, :client_id),
           Rails.application.credentials.dig(:patreon, :client_secret),
           scope: "identity[email] identity.memberships"

  provider :developer unless Rails.env.production? # You should replace it with your provider
end
