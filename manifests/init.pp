# == Class: marathon
#
# This module manages the Marathon framework for Mesos.
#
# === Authors
#
# Paul Otto <paul@ottoops.com>
#
# === Copyright
#
# Copyright 2015 Paul Otto.
#
class marathon (
  $ensure = $marathon::params::ensure,
  $enable = $marathon::params::enable,
  $force_provider = $marathon::params::force_provider,
  $owner = $marathon::params::owner,
  $group = $marathon::params::group,
  $version = $marathon::params::version,
  $repo = $marathon::params::repo,
  $marathon_dir = $marathon::params::marathon_dir,
  $conf_dir = $marathon::params::conf_dir,
  $zookeeper = $marathon::params::zookeeper,
  $mesos_role = $marathon::params::mesos_role,
  $event_subscriber = $marathon::params::event_subscriber,
  $http_endpoints = $marathon::params::http_endpoints,
  $service_enable = $marathon::params::service_enable,
  $service_ensure = $marathon::params::service_ensure,
  $service_manage = $marathon::params::service_manage,
  $service_name = $marathon::params::service_name,
  $package_ensure = $marathon::params::package_ensure,
  $package_name = $marathon::params::package_name,
  $task_launch_timeout = $marathon::params::task_launch_timeout
) inherits marathon::params {

  $marathon_ensure = $version ? {
    undef    => $ensure,
    default  => $version,
  }

  require ::mesos::master

  anchor {'marathon::begin': } ->
  class {'::marathon::repo': } ->
  class {'::marathon::install': } ->
  class {'::marathon::config': } ~>
  class {'::marathon::service': } ->
  anchor {'marathon::end': }

}
