class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #check_authorization
  rescue_from JIRA::OauthClient::UninitializedAccessTokenError do
    redirect_to sessions_new_path, notice: 'UninitializedAccessTokenError'
  end

  private

  def jira_client

    options = {
              username: session[:user].nil? ? params[:sessions][:username] : session[:user],
              private_key_file: 'rsakey.pem',
              site: 'http://localhost:2990',
              context_path: '/jira',
              consumer_key: 'test',
              consumer_name: 'JiraLoginExample'
            }

    @jira_client = JIRA::Client.new(options)

    # Add AccessToken if authorised previously.
    if session[:jira_auth]
      @jira_client.set_access_token(
        session[:jira_auth][:access_token],
        session[:jira_auth][:access_key]
      )
    end

  end

end
