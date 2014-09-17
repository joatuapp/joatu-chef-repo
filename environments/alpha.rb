name "alpha"
description "Alpha Environment"

# Keeping it DRY.
db = "joatu_alpha"
db_username = "joatu_app"
db_host = "localhost"

default_attributes(
  "active_applications" => {
    "joatu_app" => {
      "ruby_version" => "2.1.2",
      "rails_env" => "production",
      "domain_names" => [
        "api.alpha.joatu.org", 
        "alpha.joatu.org"
      ],
      "database_info" => {
        "host" => db_host,
        "adapter" => "postgis",
        "database" => db,
        "username" => db_username,
      },
      "env_vars" => {
        "UNICORN_COUNT" => 3,
        # TODO: Consolidate some of these host related
        # ENV variables. Too much duplication here!
        "API_ENDPOINT" => "api.alpha.joatu.org",
        "APP_HOST" => "alpha.joatu.org",
        "API_SUBDOMAIN" => "api.alpha",
        "CORS_ORIGINS" => "alpha.joatu.org",
        "DEVISE_MAILER_SENDER" => "noreply@joatu.org",
        "PG_DB" => db,
        "PG_HOST" => db_host,
        "PG_USER" => db_username,
      }
    }
  },
  "ssh_deploy_keys" => [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDea3sUR/Z4LKX/o8i4/j4hJZb1EL8IfxshkitVjW10daspV7hSKWYvDpTQbSt6tYq7FKroEl1PXFwVPdk5Xo4lpgVj/LM3qLAqkMHjyZUnx5VcXTjOVYfXuJsdgwvj/kbvjGrLL68/jbUiPoKymQNE+2tslA6TSXsrp5foQRQQ0BKmJKfzmjzsR/UHTFs6VKe8U45OHgYgmW6n8xSDEh5URR4yRwDCPl/LHXAchlkXlOQVYuooENIzqoJJPJlPlMO7Ib/3B8qAzb6c8MZcbl67tylO+87mhN1VcpuFwI4NCEHHke6n4XscXFtqFHd17wJ7RH83F4Bx67O0H3QAN3vH alex@undergroundwebdevelopment.com"
  ]
)
