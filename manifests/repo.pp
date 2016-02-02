# == Class: marathon::repo
#
# This class manages apt/yum repository for Marathon packages
#
# === Authors
#
# Paul Otto <paul@ottoops.com>
#
# === Copyright
#
# Copyright 2015 Paul Otto.
#
class marathon::repo {

  if $marathon::repo {
    case $::osfamily {
      'Debian': {
        if !defined(Class['apt']) {
          class { 'apt': }
        }

        $distro = downcase($::operatingsystem)

        case $marathon::repo {
          undef: {} #nothing to do
          'mesosphere': {
            apt::source { 'mesosphere':
              location    => "http://repos.mesosphere.io/${distro}",
              release     => $::lsbdistcodename,
              repos       => 'main',
              key         => 'E56151BF',
              key_server  => 'keyserver.ubuntu.com',
              include_src => false,
            }
          }
          default: {
            notify { "APT repository '${marathon::repo}' is not supported for ${::osfamily}": }
          }
        }
      }
      'redhat': {
        case $marathon::repo {
          undef: {} #nothing to do
          'mesosphere': {
            $osrel = $::operatingsystemmajrelease
            case $osrel {
              '6': {
                $mrel = '2'
              }
              '7': {
                $mrel = '1'
              }
              default: {
                notify { "'${mrel}' is not supported for ${marathon::repo}": }
              }
            }
            case $osrel {
              '6', '7': {
                package { 'mesosphere-el-repo':
                  ensure   => present,
                  provider => 'rpm',
                  source   => "http://repos.mesosphere.io/el/${osrel}/noarch/RPMS/mesosphere-el-repo-${osrel}-${mrel}.noarch.rpm"
                }
              }
              default: {
                notify { "Yum repository '${marathon::repo}' is not supported for major version ${::operatingsystemmajrelease}": }
              }
            }
          }
        }
      }
      default: {
        fail("\"${module_name}\" provides no repository information for OSfamily \"${::osfamily}\"")
      }
    }
  }
}
