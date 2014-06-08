# Define roles, user and IP address of deployment server
# role :name, %{[user]@[IP adde.]}
role :app, %w{deploy@musicsummer.lv}
role :web, %w{deploy@musicsummer.lv}
role :db,  %w{deploy@musicsummer.lv}

# Define server(s)
server 'musicsummer.lv', user: 'deploy', roles: %w{web}

# SSH Options
# See the example commented out section in the file
# for more options.
set :ssh_options, { :forward_agent => true }
