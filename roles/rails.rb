name 'rails'
description 'This role configures a Rails stack using Unicorn'
run_list(
  "role[base]",
  "recipe[packages]",
  "recipe[nginx]",
  "recipe[rails]",
  "recipe[ruby_build]",
  "recipe[rbenv]",
  "recipe[rails::databases]",
  "recipe[git]",
  "recipe[ssh_deploy_keys]",
  "recipe[postfix]",
  "recipe[rails::env_vars]"
)

default_attributes(
  "nginx" => { "server_tokens" => "off" },
  "rails" => { "applications_root" => "/data/web" },
  "rbenv" => {
    "group_users" => ['deploy']
  },
  "deploy_users" => [
        "deploy"
  ],
  "authorization" => {
    "sudo" => {
      "users" => ["deploy"]
    }
  }
)
