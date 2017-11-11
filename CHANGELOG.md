# chef_zpool Cookbook CHANGELOG

This file is used to list changes made in each version of the chef_zpool cookbook.

## 0.1.0 (2017-11-10)

- This cookbook has been forked as the chef_zpool cookbook and significantly refactored.
- Rewrote as a custom resource with support for Chef 13. Requires Chef 12.7 or later.
- New raid property in the zpool resource with support for raid-z
- Remove the need for the state and info properties on the existing LWRP. Use simple methods instead. This prevents state properties appearing to update incorrectly.
- Switched testing to from Rake -> Delivery local mode and ServerSpec -> InSpec
- Eliminated the need for the helper recipe on Solaris for testing

## 0.0.3

* Add the force and mountpoint resource options.
* Set up test-kitchen use and add serverspec tests
* Clean up rubocop offences
* Use zpool status instead of zpool list -v to find volumes in use. "-v" is not
  a valid solaris option.
* When the ashift option value is 0 don't add the option to the create command.
