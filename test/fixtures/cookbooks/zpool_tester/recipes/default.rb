# install zpool support
apt_update if platform_family?('debian')

package 'zfs' do
  only_if { platform_family?('debian') }
end

# set up zpools
(0..8).each do |id|
  execute id do
    command "dd if=/dev/zero of=/disk#{id} bs=1024 count=65536"
    not_if { File.exist?("/#{id}") }
  end
end

zpool 'create_zpool1' do
  name 'zpool1'
  disks %w(/disk0)
end

zpool 'create_zpool1' do
  name 'zpool2'
  disks %w(/disk1)
end

zpool 'create_multiplevolumes' do
  name 'multiplevolumes'
  disks %w(/disk2 /disk3)
  force true
end

zpool 'destroy_zpool' do
  name 'zpool2'
  action :destroy
end

zpool 'test' do
  disks %w(/disk4 /disk5)
end

zpool 'create raidz' do
  name 'tank'
  # rubocop:disable Lint/ParenthesesAsGroupedExpression
  disks (6..8).map { |id| "/disk#{id}" }
  raid 'raidz'
end
