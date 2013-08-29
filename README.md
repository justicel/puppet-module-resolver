Resolver module for Puppet
==========================

Usage
-----

```puppet
class { '::resolver':
  searchpath  => [ 'cat.pdx.edu', 'cs.pdx.edu', 'pdx.edu']
  options     => 'ndots:3',
  sortlist    => [
    '131.252.208.32/255.255.255.224',
    '131.252.220.0/255.255.255.192',
  ],
  nameservers => [
    '131.252.0.53',
    '131.252.120.128',
  ];
}
```
