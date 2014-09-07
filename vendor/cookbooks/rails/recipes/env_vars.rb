applications_root = node[:rails][:applications_root]

if node[:active_applications]
  node[:active_applications].each do |app, app_info|
    env_vars = app_info["env_vars"] || {}

    # This code block understands how to load a hash 
    # of env_vars from a databag item named after the 
    # app, and insert those values into the app_info.
    data_bag_item = app_info['data_bag_item'] || app
    search(:applications, "id:#{data_bag_item}").each do |app_secrets|
      if app_secrets.key? 'env_vars'
        app_secrets['env_vars'].each {|k,v| env_vars[k] = v }
      end
    end

    deploy_user = app_info['deploy_user'] || "deploy"
    template "#{applications_root}/#{app}/shared/.rbenv-vars" do
      source "app_env_vars.erb"
      mode 0600
      owner deploy_user
      group deploy_user
      variables(env_vars: env_vars)
    end
  end
end
