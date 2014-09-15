include_recipe "database"

if node[:active_applications]
  node[:active_applications].each do |app, app_info|

    # This code block understands how to load the database
    # password from a databag item named after the app, 
    # and insert those values into the app_info.
    database_password = nil
    data_bag_item = app_info['data_bag_item'] || app
    search(:applications, "id:#{data_bag_item}").each do |app_secrets|
      if app_secrets.key?('database_info') && app_secrets['database_info'].key?('password')
        database_password = app_secrets['database_info']['password']
      end
    end

    if app_info['database_info'] && database_password
      database_info = app_info['database_info']
      database_name = app_info['database_info']['database']
      database_username = database_info['username']

      if database_info['adapter'] =~ /mysql/
        include_recipe 'database::mysql'

        mysql_connection_info = {:host => "localhost", :username => "root", :password => node['mysql']['server_root_password']}

        mysql_database database_name do
          connection(mysql_connection_info)
        end

        mysql_database_user database_username do
          connection(mysql_connection_info)
          username database_username
          password database_password
          database_name(database_name)
          table "*"
          host "localhost"
          action :grant
        end
      elsif database_info['adapter'] == 'postgresql' || database_info['adapter'] == 'postgis'
        execute "create-database-user" do
          psql = "psql -U postgres -c \"CREATE USER \\\"#{database_username}\\\" WITH PASSWORD '#{database_password}'\""
          user 'postgres'
          command psql
          returns [0,1]
        end
 
        execute "create-database" do
          user 'postgres'
          command "createdb -U postgres -O #{database_username} #{database_name}"
          returns [0,1]
        end

        execute "install-postgis" do
          user 'postgres'
          command "psql -U postgres -c \"CREATE EXTENSION IF NOT EXISTS \\\"postgis\\\"\""
          returns [0,1]
        end

        execute "install-plpgsql" do
          user 'postgres'
          command "psql -U postgres -c \"CREATE EXTENSION IF NOT EXISTS \\\"plpgsql\\\"\""
          returns [0,1]
        end

        execute "install-uuid-ossp" do
          user 'postgres'
          command "psql -U postgres -c \"CREATE EXTENSION IF NOT EXISTS \\\"uuid-ossp\\\"\""
          returns [0,1]
        end
      end
    end
  end

end
