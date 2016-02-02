# == Define: marathon::property
#
# Store configuration in directory structure.
#
# === Parameters
# 
#   $title   - filename to manage
#   $dir     - directory name to access file in 
#   $value   - content for the file
#   $service - service to notify about property changes
#
# === Authors
#
# Paul Otto <paul@ottoops.com>
#
# === Copyright
#
# Copyright 2015 Paul Otto.
#
define marathon::property (
  $value,
  $dir,
  $service = undef,
  $file = $title,
) {

  if is_bool($value) {
    $filename = $value ? {
      true => "${dir}/?${file}",
      false => "${dir}/?no-${file}",
    }
    $ensure = 'present'
    $content = ''
  } else {
    $filename = "${dir}/${file}"
    $ensure = empty($value) ? {
      true  => absent,
      false => present,
    }
    $content = $value
  }

  file { $filename:
    ensure  => $ensure,
    content => $content,
    require => File[$dir]
    #notify  => $service,
  }

}
