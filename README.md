# firewall_multi

##Overview

The `firewall_multi` module provides a defined type wrapper for spawning [puppetlabs/firewall](https://github.com/puppetlabs/puppetlabs-firewall) resources for arrays of certain inputs, namely sources, destinations and ICMP types.

##Usage

It is expected that a standard set up for the firewall module is followed, in particular with respect to the purging of firewall resources.  If a user of this module, for instance, removes addresses from an array of sources, the corresponding firewall resources will only be removed if purging is enabled.  This might be surprising to the user in a way that impacts security.

Otherwise, usage of the firewall_multi defined type is the same as with the firewall custom type, the only exceptions being that the source, destination and icmp parameters optionally accept arrays.

##Parameters

* `source`: the source IP address or network or an array of sources.  Use of this parameter causes a firewall resource to be spawned for each address in the array of sources, and a string like 'from *x.x.x.x/x*' to be appened to each spawned resource's title to guarantee uniqueness in the catalog.  If not specified, a default of undef is used and the resultant firewall resource provider will not be passed a source.

* `destination`: the destination IP address or network or an array of destinations.  Use of this parameter causes a firewall resource to be spawned for each address in the array of destinations, and a string like 'to *y.y.y.y/y*' to be appended to each spawned resource's title to guarantee uniqueness in the catalog.  If not specified, a default of undef is used and the resultant firewall resource provider will not be passed a destination.

* `icmp`: the ICMP type or an array of ICMP types specified as an array of integers or strings.  Use of this parameter causes a firewall resource to be spawned for each address in the array of ICMP types, and a string like 'icmp type *nn*' to be appended to each spawned resource's title to guarantee uniqueness in the catalog.  If not specified, a default of undef is used and the resultant firewall resource provider will not be passed an ICMP type.

* Any other parameter accepted by firewall is also accepted and set for each firewall resource created without error-checking.

##Examples

~~~puppet
firewall_multi { '100 allow http and https access':
  source => [
    '10.0.0.10/24',
    '10.0.0.12/24',
    '10.1.1.128',
  ],
  dport  => [80, 443],
  proto  => tcp,
  action => accept,
}
~~~

This will cause three resources to be created:

* Firewall['100 allow http and https access from 10.0.0.10/24']
* Firewall['100 allow http and https access from 10.0.0.12/24']
* Firewall['100 allow http and https access from 10.1.1.128']

~~~puppet
firewall_multi { '100 allow http and https access':
  source => [
    '10.0.0.10/24',
    '10.0.0.12/24',
  ],
  destination => [
    '10.2.0.0/24',
    '10.3.0.0/24',
  ],
  dport  => [80, 443],
  proto  => tcp,
  action => accept,
}
~~~

This will cause four resources to be created:

* Firewall['100 allow http and https access from 10.0.0.10/24 to 10.2.0.0/24']
* Firewall['100 allow http and https access from 10.0.0.10/24 to 10.3.0.0/24']
* Firewall['100 allow http and https access from 10.0.0.12/24 to 10.2.0.0/24']
* Firewall['100 allow http and https access from 10.0.0.12/24 to 10.3.0.0/24']

~~~puppet
firewall_multi { '100 allow http and https access':
  dport  => [80, 443],
  proto  => tcp,
  action => accept,
}
~~~

This will cause one resource to be created:

* Firewall['100 allow http and https']

~~~puppet
firewall_multi { '100 accept icmp ouput'
  chain  => 'OUTPUT',
  proto  => 'icmp',
  action => 'accept',
  icmp   => [0, 8],
}
~~~

This will cause two resources to be created:

* Firewall['100 accept icmp ouput icmp type 0']
* Firewall['100 accept icmp ouput icmp type 8']

##Known Issues

At the moment, only the latest version of puppetlabs/firewall is supported, namely >= 1.8.0.

This module does not sanity-check the proposed inputs for the resultant firewall resources.  We assume that we can rely on the firewall resource types themselves to detect invalid inputs.

Finally, at this stage there are no Beaker acceptance tests.

##Development

Please read CONTRIBUTING.md before contributing.

###Testing

Make sure you have:

* rake
* bundler

Install the necessary gems:

    bundle install

To run the tests from the root of the source code:

    bundle exec rake spec
