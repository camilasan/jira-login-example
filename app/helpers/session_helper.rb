module SessionHelper

  def authorize_jira_projects
    link_to 'Jira Projects', sessions_authorize_path(oauth_verifier: params[:oauth_verifier])
  end

  def show_jira_projects
    projects = ''
    @jira_client.Project.all.each do |project|
      projects += "#{project.name}..."
    end
    projects
  end

end
