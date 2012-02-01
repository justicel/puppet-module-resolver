##
# Resolv Module init.pp
#
# Computer Action Team
# Maseeh College of Engineering & Computer Science
#

class resolver (
  $domainname  = "$domain", 
  $searchpath  = undef,
  $nameservers = undef,
  $options     = undef,
  $sortlist    = undef
) {
  include resolver::params

  $specialoptions = $options or $sortlist

  ##
  # Virtual files. declared here because some files use templating
  # and variables in this scope.
  @file {
    "resolver/manual_resolv_conf":
      path    => $resolver::params::dhclientoverride,
      ensure  => $specialoptions ? {
        true    => file,
        default => absent,
      },
      owner   => "root",
      group   => "root",
      mode    => "755",
      content => "#!/bin/sh\nmake_resolv_conf () { :; }\n";
    "resolver/resolv.conf":
      path    => "/etc/resolv.conf",
      owner   => "root",
      mode    => "644",
      content => template("resolver/resolv.conf.erb");
    "resolver/dhclient.conf":
      path    => $resolver::params::dhclientfile,
      owner   => "root",
      group   => "root",
      mode    => "644",
      content => template("resolver/dhclient.conf.erb");
  }

  ##
  # If this is ubuntu, don't rewrite the resolv.conf file when using dhcp.
  # If you want it rewritten, don't declare it manually in puppet.
  case $operatingsystem {
    "Ubuntu": { 
      if $options == undef and $sortlist == undef {
        realize File["resolver/dhclient.conf"]
      } else {
        realize File["resolver/dhclient.conf"]
        realize File["resolver/manual_resolv_conf"]
        realize File["resolver/resolv.conf"]
      }
    }
    default:  {
      realize File["resolver/resolv.conf"]
    }
  }
}
