name              'chef_zpool'
maintainer        'Chef Software Inc.'
maintainer_email  'cookbooks@chef.io'
license           'Apache-2.0'
description       'Manages ZFS zpools'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.1.0'
source_url        'https://github.com/chef-cookbooks/chef_zpool'
issues_url        'https://github.com/chef-cookbooks/chef_zpool/issues'

%w(solaris2 ubuntu freebsd).each do |os|
  supports os
end

chef_version '>= 12.7'
