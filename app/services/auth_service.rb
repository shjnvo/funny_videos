module AuthService
  # REPLACE WITH VALID REDIRECT_URI FOR YOUR CLIENT
  REDIRECT_URI = 'http://localhost'
  APPLICATION_NAME = 'funny_videos'

  # REPLACE WITH NAME/LOCATION OF YOUR client_secrets.json FILE
  CLIENT_SECRETS_PATH = 'client_secret.json'

  # REPLACE FINAL ARGUMENT WITH FILE WHERE CREDENTIALS WILL BE STORED
  CREDENTIALS_PATH = File.join(Rails.root,
                               "youtube-credentials.yaml")

  # SCOPE FOR WHICH THIS SCRIPT REQUESTS AUTHORIZATION
  SCOPE = 'https://www.googleapis.com/auth/youtube'

  APPLICATION_NAME = 'funny_videos'

  def authorize
    FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

    client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(
      client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)

    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: REDIRECT_URI)
      puts "Open the following URL in the browser and enter the " +
           "resulting code after authorization"
      puts url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: REDIRECT_URI)
    end

    credentials
  end
end