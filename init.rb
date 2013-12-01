require 'redmine'
require_dependency 'redmine_github_auth/hooks'

Redmine::Plugin.register :redmine_github_auth do
  name 'Redmine GitHub Authentication'
  author 'Tim De Pauw'
  description 'Lets existing users log in via GitHub'
  version '0.0.1'
  url 'https://github.com/timdp/redmine_github_auth'
  author_url 'https://github.com/timdp'

  settings :default => {
    :github_url => "https://github.com",
    :github_api_url => "https://api.github.com",
    :client_id => "",
    :client_secret => "",
    :enabled => false,
  }, :partial => 'settings/github_settings'
end
