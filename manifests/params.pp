class resolver::params {
  case $operatingsystem {
    "Ubuntu": {
      case $lsbdistcodename {
        "lucid", "jaunty": {
          $dhclientfile     = "/etc/dhcp3/dhclient.conf"
          $dhclientoverride = "/etc/dhcp3/dhclient-enter-hooks.d/manual_resolv_conf"
        }
        default: {
          $dhclientfile     = "/etc/dhcp/dhclient.conf"
          $dhclientoverride = "/etc/dhcp/dhclient-enter-hooks.d/manual_resolv_conf"
        }
      }
    }
    default: {
      $dhclientfile     = "/etc/dhcp/dhclient.conf"
      $dhclientoverride = "/etc/dhcp/dhclient-enter-hooks.d/manual_resolv_conf"
    }
  }
}
