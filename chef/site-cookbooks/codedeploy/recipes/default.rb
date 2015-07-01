
include_recipe  'apt'
bash 'apt-get autoremove' do
  code 'apt-get autoremove -y'
end
package  'build-essential'
package 'libxml2-dev'
package 'libxslt-dev'
package 'libssl-dev'
package 'libcrypto++-dev'
package 'git'
package 'jq'

bash 'make ruby2.0 the default' do
  not_if 'ruby --version | grep "ruby 2."'
  code 'ln -sf /usr/bin/ruby2.0 /usr/bin/ruby && ln -sf /usr/bin/gem2.0 /usr/bin/gem'
end

bash 'install bundler gem' do
  code 'gem install bundler'
end

bash 'bundle install' do
  user node['codedeploy']['user']
  cwd node['codedeploy']['installation_path']
  code "bundle install"
end

file "#{node['codedeploy']['installation_path']}/.env.#{node['codedeploy']['environment']}" do
  content <<-EOF
AWS_ACCESS_KEY_ID=#{node['codedeploy']['aws_access_key_id']}
AWS_SECRET_ACCESS_KEY=#{node['codedeploy']['aws_secret_access_key']}
  EOF
end

