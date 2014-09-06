name        "postgresql"
description "PostgreSQL Server Support"

run_list    "role[base]", "recipe[postgresql::server]", "recipe[postgresql::client]"

default_attributes(
  "postgresql" => {
    "enable_pgdg_apt" => true,
    "server" => {
      "packages" => [
        "postgresql-9.3-postgis-2.1"
      ]
    }
  }
)
