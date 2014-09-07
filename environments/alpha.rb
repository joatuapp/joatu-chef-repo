name "alpha"
description "Alpha Environment"

# Keeping it DRY.
db = "joatu_alpha"
db_username = "jaotu_app"

default_attributes(
  "active_applications" => {
    "joatu_alpha" => {
      "ruby_version" => "2.1.2",
      "rails_env" => "production",
      "packages" => [],
      "domain_names" => [
        "api.alpha.joatu.org", 
        "alpha.joatu.org"
      ],
      "database_info" => {
        # NOTE: This "adapter" key just triggers the recipe
        # to setup our DB. It does also get written to a
        # database.yml, but that will get over-written on
        # deploy by one that reads from ENV variables.
        "adapter" => "postgresql",
        "database" => db,
        "username" => db_username,
      },
      "env_vars" => {
        "APP_HOST" => "alpha.joatu.org",
        "API_SUBDOMAIN" => "api.alpha",
        "CORS_ORIGINS" => "alpha.joatu.org",
        "DEVISE_MAILER_SENDER" => "noreply@joatu.org",
        "PG_DB" => db,
        "PG_HOST" => "localhost",
        "PG_USERNAME" => db_username,
      }
    }
  },
  "ssh_deploy_keys" => [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDea3sUR/Z4LKX/o8i4/j4hJZb1EL8IfxshkitVjW10daspV7hSKWYvDpTQbSt6tYq7FKroEl1PXFwVPdk5Xo4lpgVj/LM3qLAqkMHjyZUnx5VcXTjOVYfXuJsdgwvj/kbvjGrLL68/jbUiPoKymQNE+2tslA6TSXsrp5foQRQQ0BKmJKfzmjzsR/UHTFs6VKe8U45OHgYgmW6n8xSDEh5URR4yRwDCPl/LHXAchlkXlOQVYuooENIzqoJJPJlPlMO7Ib/3B8qAzb6c8MZcbl67tylO+87mhN1VcpuFwI4NCEHHke6n4XscXFtqFHd17wJ7RH83F4Bx67O0H3QAN3vH alex@undergroundwebdevelopment.com"
  ]
)
