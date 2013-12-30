# encoding: UTF-8

class SessionsController < ApplicationController

  #before_filter :jira_client, only: [:create, :authorize]

  def new
    render 'new'
  end

  def create
    login_at(:jira)
  end

  def authorize
    request_token = @jira_client.set_request_token(
      session[:request_token], session[:request_secret]
    )
    access_token = @jira_client.init_access_token(
      :oauth_verifier => params[:oauth_verifier]
    )

    session[:jira_auth] = {
      :access_token => access_token.token,
      :access_key => access_token.secret
    }

    session.delete(:request_token)
    session.delete(:request_secret)
  end

  def destroy
    session.data.delete(:jira_auth)
  end

  def show
  end

end
