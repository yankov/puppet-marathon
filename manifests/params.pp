# == Class: marathon::params
#
# Params base class for marathon module.
#
# === Authors
#
# Paul Otto <paul@ottoops.com>
#
# === Copyright
#
# Copyright 2015 Paul Otto.
#
class marathon::params {
  $ensure = 'present'
  $enable = true
  $force_provider = undef
  $service_name = 'marathon'
  $service_enable = true
  $service_ensure = 'running'
  $service_manage = true
  $package_ensure = 'present'
  $package_name = 'marathon'
  $owner = 'root'
  $group = 'root'
  $version = undef
  $repo = undef
  $marathon_dir = '/etc/marathon'
  $conf_dir = '/etc/marathon/conf'
  $zookeeper = ''
  $mesos_role = ''
  $event_subscriber = ''
  $http_endpoints = ''
  $task_launch_timeout = undef
}
