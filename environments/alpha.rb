name "alpha"
description "Alpha Environment"

# TODO: Export this password to an encrypted data bag!
# We should be able to put this (and things like the
# various secrets, etc) in a data bag, and load them
# into the active_applications hash as part of the rails
# recipe.
db_password = "qxyS8jneeuZbrU@^gq3M"

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
        "adapter" => "postgresql",
        "database" => "joatu_alpha",
        "username" => "joatu_app",
        "password" => db_password
      },
      "env_vars" => {
        "APP_HOST" => "alpha.joatu.org",
        "API_SUBDOMAIN" => "api.alpha",
        "CORS_ORIGINS" => "alpha.joatu.org",
        "DEVISE_MAILER_SENDER" => "noreply@joatu.org",
        "PG_DB" => "joatu_alpha",
        "PG_HOST" => "localhost",
        "PG_USERNAME" => "joatu_app",
        "PG_PASSWORD" => db_password,
        "SECRET_KEY_BASE" => "3605789136b0cee7b9c2a9628f331d219edd6633b3863ef3a601c0657fc7570271c79a31f64e855cfd75bd583a2a3ade124dd4eabb475cc392113548e290057a",
        "DEVISE_SECRET" => "530281155820150e082d998e782883269fb9177fd409a49dd3a00fc0a5bbdaca74ddc2b77c6e995e849f5275fb015e0bc87a89b4f19b0e1939aa8fa91447eddd",
        "DEVISE_PEPPER" => "1ea6764e8661d1d165159211d01042e8e2b04f43fbfaca716ce6c29b5c5836f3fd4bbd5832de2a1c27bc1cff6f6fd149ed6e7a2fda249452519884d4f7cd9844"
      }
    }
  },
  "ssh_deploy_keys" => [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDea3sUR/Z4LKX/o8i4/j4hJZb1EL8IfxshkitVjW10daspV7hSKWYvDpTQbSt6tYq7FKroEl1PXFwVPdk5Xo4lpgVj/LM3qLAqkMHjyZUnx5VcXTjOVYfXuJsdgwvj/kbvjGrLL68/jbUiPoKymQNE+2tslA6TSXsrp5foQRQQ0BKmJKfzmjzsR/UHTFs6VKe8U45OHgYgmW6n8xSDEh5URR4yRwDCPl/LHXAchlkXlOQVYuooENIzqoJJPJlPlMO7Ib/3B8qAzb6c8MZcbl67tylO+87mhN1VcpuFwI4NCEHHke6n4XscXFtqFHd17wJ7RH83F4Bx67O0H3QAN3vH alex@undergroundwebdevelopment.com"
  ]
)
