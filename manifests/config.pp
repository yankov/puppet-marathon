# == Class: marathon::config
#
# Manage Marathon configuration files.
#
# === Authors
#
# Paul Otto <paul@ottoops.com>
#
# === Copyright
#
# Copyright 2015 Paul Otto.
#
class marathon::config {

  file { [$marathon::marathon_dir, $marathon::conf_dir]:
    ensure => directory,
    owner  => $marathon::owner,
    group  => $marathon::group,
  }

  marathon::property {'mesos_role':
    value   => $marathon::mesos_role,
    dir     => $marathon::conf_dir,
    require => File[$marathon::conf_dir],
    service => $marathon::service_name,
  }

  marathon::property {'master':
    value   => $marathon::zookeeper,
    dir     => $marathon::conf_dir,
    require => File[$marathon::conf_dir],
    service => $marathon::service_name,
  }

  marathon::property {'zk':
    value   => $marathon::zookeeper,
    dir     => $marathon::conf_dir,
    require => File[$marathon::conf_dir],
    service => $marathon::service_name,
  }

  marathon::property {'event_subscriber':
    value   => $marathon::event_subscriber,
    dir     => $marathon::conf_dir,
    require => File[$marathon::conf_dir],
    service => $marathon::service_name,
  }

  marathon::property {'http_endpoints':
    value   => $marathon::http_endpoints,
    dir     => $marathon::conf_dir,
    require => File[$marathon::conf_dir],
    service => $marathon::service_name,
  }

  if !empty($marathon::task_launch_timeout) {
    marathon::property {'task_launch_timeout':
      value   => $marathon::task_launch_timeout,
      dir     => $marathon::conf_dir,
      require => File[$marathon::conf_dir],
      service => $marathon::service_name,
    }
  }
}
