# -*- encoding: utf-8 -*-
#
# Author:: Ryan Hass (<rhass@chef.io>)
# Author:: Martha Greenberg (<'marthag@mit.edu'>)
# Copyright (C) 2017, Chef Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource_name :zpool

property :ashift, Integer, default: 0
property :disks, Array, default: []
property :force, [true, false], default: false
property :mountpoint, String
property :recursive, [true, false], default: false
property :raid, [String, NilClass], equal_to: %w(mirror raidz raidz2 raidz3)

action :create do
  if created?
    if online?
      disks.each do |disk|
        short_disk = disk.split('/').last
        next if vdevs.include?(short_disk)
        next if vdevs.include?(disk)
        Chef::Log.info("Adding #{disk} to pool #{new_resource.name}")
        shell_out!("zpool add #{args_from_resource} #{new_resource.name} #{disk}")
      end
    else
      Chef::Log.warn("Zpool #{new_resource.name} is #{state}")
    end
  else
    Chef::Log.info("Creating zpool #{new_resource.name}")
    mount_point = new_resource.mountpoint ? "-m #{new_resource.mountpoint}" : ''
    shell_out!("zpool create #{mount_point} #{args_from_resource} #{new_resource.name} #{new_resource.raid} #{new_resource.disks.join(' ')}")
  end
end

action :destroy do
  if created?
    Chef::Log.info("Destroying zpool #{new_resource.name}")
    shell_out!("zpool destroy #{args_from_resource} #{new_resource.name}")
  end
end

action_class do
  def args_from_resource
    args = []
    args << '-f' if new_resource.force
    args << '-r' if new_resource.recursive

    # Properties
    if new_resource.ashift > 0
      args << '-o'
      args << format('ashift=%s', new_resource.ashift)
    end

    args.join(' ')
  end

  def created?
    info.exitstatus == 0
  end

  def state
    info.stdout.chomp
  end

  def info
    shell_out("zpool list -H -o health #{new_resource.name}")
  end

  def vdevs
    @vdevs ||= shell_out!("zpool status #{new_resource.name}").stdout.lines.map do |line|
      next unless line.chomp =~ /^[\t]  /
      line.chomp.split("\s")[0]
    end
  end

  def online?
    state == 'ONLINE'
  end
end
