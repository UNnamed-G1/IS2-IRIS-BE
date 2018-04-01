# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
<<<<<<< HEAD
    origins 'localhost:4200', '/\Ahttps:\/\/is2-iris-fe.herokuapp.com\z/', '/\Ahttp:\/\/is2-iris-fe.herokuapp.com\z/'
=======
    origins 'localhost:4200', 'is2-iris-fe.herokuapp.com'
>>>>>>> 2a17ac50860059ff31aaa5e43e5ab5293bd39514

    resource '*',
      headers: :any,
      expose: ['access_token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
