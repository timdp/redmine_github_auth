get 'oauth_github', :to => 'redmine_oauth#oauth_github'
get 'oauth_github_callback', :to => 'redmine_oauth#oauth_github_callback', :as => 'oauth_github_callback'
