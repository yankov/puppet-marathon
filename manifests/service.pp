# == Class: marathon::service
#
# This module manages Marathon services
#
# Parameters:
#  [*enable*] - enable service autostart
#  [*force_provider*] - choose a service provider; default = undef = system default; 'none' does not create a service resource at all.
#
# Should not be called directly
#
# === Authors
#
# Paul Otto <paul@ottoops.com>
#
# === Copyright
#
# Copyright 2015 Paul Otto.
#
class marathon::service {

  if ! ($marathon::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $marathon::service_manage == true {
    service { 'marathon':
      ensure     => $marathon::service_ensure,
      enable     => $marathon::service_enable,
      name       => $marathon::service_name,
      provider   => $marathon::force_provider,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
