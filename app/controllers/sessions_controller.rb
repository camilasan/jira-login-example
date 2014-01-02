# encoding: UTF-8

class SessionsController < ApplicationController

  def new
    render 'new'
  end

  def create
    login_at(:jira)
  end

  def destroy
    session.data.delete(:jira_auth)
  end

  def show
  end

end
