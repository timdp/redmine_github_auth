require 'account_controller'
require 'json'

class RedmineOauthController < AccountController
  def oauth_github
    if Setting.plugin_redmine_omniauth_github[:enabled]
      session[:back_url] = params[:back_url]
      redirect_to oauth_client.auth_code.authorize_url(:redirect_uri => oauth_github_callback_url, :scope => scopes)
    else
      password_authentication
    end
  end

  def oauth_github_callback
    if params[:error]
      flash[:error] = l(:notice_access_denied)
      redirect_to signin_path
    else
      token = oauth_client.auth_code.get_token(params[:code], :redirect_uri => oauth_github_callback_url)
      user_resp = token.get(Setting.plugin_redmine_omniauth_github[:github_api_url] + '/user')
      user_info = JSON.parse(user_resp.body)
      login = user_info["login"]

      params[:back_url] = session[:back_url]
      session.delete(:back_url)

      if (user = User.find_by_login(login))
        if user.active?
          successful_authentication(user)
        else
          account_pending
        end
      else
        flash[:error] = l(:notice_user_not_found)
        redirect_to signin_path
      end
    end
  end

  def oauth_client
    @client ||= OAuth2::Client.new(settings[:client_id], settings[:client_secret],
      :site => Setting.plugin_redmine_omniauth_github[:github_url],
      :authorize_url => '/login/oauth/authorize',
      :token_url => '/login/oauth/access_token')
  end

  def settings
    @settings ||= Setting.plugin_redmine_omniauth_github
  end

  def scopes
    'user'
  end
end
