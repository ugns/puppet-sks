[![Build Status](https://travis-ci.org/UGNS/puppet-sks.png?branch=master)](https://travis-ci.org/UGNS/puppet-sks)

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with sks](#setup)
    * [What sks affects](#what-sks-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with sks](#beginning-with-sks)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

SKS is an OpenPGP key server that correctly handles all OpenPGP features defined
in RFC2440 and RFC2440bis, including photoID  packages and multiple subkeys.

##Module Description

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section should
answer the questions: "What does this module *do*?" and "Why would I use it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

##Setup

###What sks affects

Manages the following files for you:
* /etc/sks/sksconf
* /etc/sks/membership

###Setup Requirements

The module does not handle retrieving the initial keydump to seed the key
server. This will have to be done manually and then enable the server to boot
by modifying the `/etc/default/sks` to allow the init script to start the
server daemon.

If you want to join the SKS network you'll need to put your key server behind
a reverse proxy. Many key servers run behind nginx or Apache. You can accomplish
this easily with existing Forge modules.

###Beginning with sks

It is highly recommended that you read the [SKS Wiki](https://bitbucket.org/skskeyserver/sks-keyserver/wiki/Home)
to better understand the key server if you are unfamiliar.

##Usage

The SKS module is designed to work with minimum configuration needed following
best practices from other SKS operators.

```puppet
  class { 'sks': }
```

This will confiugre the server and is recommended to start out a new server.
Once you've imported your keydump and have your server up and ready for peering
you will need to begin adding peers. If you're using Hiera this is as simple as:

```YAML
sks::members:
  - hostname: sks.undergrid.net
    admin: Jeremy T. Bouse
    email: Jeremy.Bouse@UnderGrid.net
    keyid: '0xD01E190C'
```

This can also be accomplished without Hiera as:

```puppet
  class { 'sks':
    members => [{
      hostname => 'sks.undergrid.net',
      admin    => 'Jeremy T. Bouse',
      email    => 'Jeremy.Bouse@UnderGrid.net',
      keyid    => '0xD01E190C',
    ]],
  }
```

##Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module
so people know what the module is touching on their system but don't need to
mess with things. (We are working on automating this section!)

##Limitations

While OS packaging has been made available for both RPM and DEB based systems,
the module has only been actually tested on Debian/Ubuntu based systems.

##Development

If you want to contribute feel free to fork the repository and submit a pull
request for inclusion.
