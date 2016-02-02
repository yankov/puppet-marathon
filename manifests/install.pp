# == Class: marathon::install
#
# This class manages Marathon package installation.

class marathon::install {

   $version = "0.14.0"
   $package_filename = "marathon_${version}-1.0.450.ubuntu1404_amd64.deb"

   exec { "wget ${package_filename}":
     command => "/usr/bin/wget -q https://s3.amazonaws.com/reddit-packages/any/amd64/${package_filename} -O /tmp/${package_filename}",
     creates => "/tmp/${package_filename}",
     cwd     => '/',
     user    => 'root',
   }

   file { "/tmp/${package_filename}":
     owner   => 'root',
     group   => 'root',
     mode    => '0644',
     require => Exec["wget ${package_filename}"],
   }

   package { "marathon":
     provider => 'dpkg',
     ensure => held,
     source   => "/tmp/${package_filename}",
     require  => Exec["wget ${package_filename}"],
   }

}
