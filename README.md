# chef_zpool Cookbook

[![Build Status](https://travis-ci.org/chef-cookbooks/chef_zpool.svg?branch=master)](https://travis-ci.org/chef-cookbooks/chef_zpool) [![Cookbook Version](https://img.shields.io/cookbook/v/chef_zpool.svg)](https://supermarket.chef.io/cookbooks/chef_zpool)

A resource for creating and destroying zpools. This cookbook is forked from the original zpools cookbook by Martha Greenberg at <https://github.com/marthag8/zpool>.

## Requirements

### Platforms

- Ubuntu
- FreeBSD
- Solaris

### Chef

- Chef 12.7+

### Cookbooks

- none

## Resources

### zpool

#### Actions

- `:create` - Create a new zpool
- `:destroy` - Destroy and existing zpool

#### Properties

- `ashift` - Set sector size, support by the OS is not verified.
- `disks` - Array of disks to put in the pool.
- `force` - Force the use of vdevs, even if they appear to be in use.
- `mountpoint` - Mountpoint for the top-level file system, absolute path or 'none'.
- `recursive` - Add a -r to the command.
- `raid` - The RAID type of the zpool. mirror, raidz, raidz2, or raidz3

#### Examples

```
zpool "test" do
  disks [ "c0t2d0s0", "c0t3d0s0" ]
end

zpool "test2" do
  action :destroy
end
```

## Maintainers

This cookbook is maintained by Chef's Community Cookbook Engineering team. Our goal is to improve cookbook quality and to aid the community in contributing to cookbooks. To learn more about our team, process, and design goals see our [team documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/COOKBOOK_TEAM.MD). To learn more about contributing to cookbooks like this see our [contributing documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/CONTRIBUTING.MD), or if you have general questions about this cookbook come chat with us in #cookbok-engineering on the [Chef Community Slack](http://community-slack.chef.io/)

## License

**Copyright:** 2012-2017, Martha Greenberg **Copyright:** 2017, Chef Software, Inc.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
