require 'redmine'
require_dependency 'redmine_omniauth_github/hooks'

Redmine::Plugin.register :redmine_omniauth_github do
  name 'Redmine OmniAuth GitHub plugin'
  author 'Marek Hulan, Tim De Pauw'
  description 'Lets existing users log in via GitHub'
  version '0.0.2'
  url 'https://github.com/ares/redmine_omniauth_github'
  author_url 'https://github.com/timdp'

  settings :default => {
    :github_url => "https://github.com",
    :github_api_url => "https://api.github.com",
    :client_id => "",
    :client_secret => "",
    :enabled => false,
  }, :partial => 'settings/github_settings'
end
