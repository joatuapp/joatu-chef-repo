# See http://docs.getchef.com/config_rb_knife.html for more information on knife configuration options
current_dir = File.dirname(__FILE__)
user_email  = `git config --get user.email`
home_dir    = ENV['HOME'] || ENV['HOMEDRIVE']
org         = ENV['chef_org'] || 'Underground Web Development'

knife_override = "#{home_dir}/.chef/knife_override.rb"

chef_server_url          "https://api.opscode.com/organizations/#{org}"
log_level                :info
log_location             STDOUT

validation_client_name   "joatu-validator"
validation_key           "#{current_dir}/joatu-validator.pem"

data_bag_encrypt_version 2

# USERNAME is UPPERCASE in Windows, but lowercase in the Chef server,
# so `downcase` it.
node_name                ( ENV['OPSCODE_USER'] || ENV['USER'] || ENV['USERNAME'] ).downcase
client_key               "#{home_dir}/.chef/#{node_name}.pem"
cache_type               'BasicFile'
cache_options( :path => "#{home_dir}/.chef/checksums" )

# We keep our cookbooks in separate repos under a ~/chef/cookbooks dir
cookbook_path            ["#{current_dir}/../cookbooks"]
cookbook_copyright       "#{org} copyright #{Time.now.strftime("%Y")}"
cookbook_license         "none"
cookbook_email           "#{user_email}"

if File.exist? "#{current_dir}/data_bag_secret.pem"
  knife[:secret_file] = "#{current_dir}/data_bag_secret.pem"
end

# Gem: knife-ec2
knife[:aws_access_key_id]      = ENV["AWS_ACCESS_KEY_ID"]
knife[:aws_secret_access_key]  = ENV["AWS_SECRET_ACCESS_KEY"]

# Default options for ec2 opperations:
knife[:flavor]                 = "t2.micro"
knife[:image]                  = "ami-e7b8c0d7"
knife[:region]                 = "us-west-2"
knife[:aws_ssh_key_id]         = ENV["AWS_SSH_KEY_ID"]
knife[:ssh_user]               = "ubuntu"

# Allow overriding values in this knife.rb
Chef::Config.from_file(knife_override) if File.exist?(knife_override)
