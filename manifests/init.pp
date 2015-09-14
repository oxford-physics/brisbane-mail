# == Class: mail
#
# Full description of class mail here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { mail:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class mail {
  ensure_packages ( ['sendmail'])
   service{  sendmail:
                   ensure => running,
                   hasstatus => true,
                   hasrestart => true,
                   enable => true,
                   require => Package['sendmail']
        }

    @concat {'/etc/mail/sendmail.mc':
          owner => root,
          group => root,
          mode  => '0644',
          notify => Service['sendmail']
   }
  realize Concat['/etc/mail/sendmail.mc']
  concat::fragment{'sendmail.mcbase':
          target  => "/etc/mail/sendmail.mc",
          content => template('mail/sendmail.mc'),
          notify => Service['sendmail']
        }


        concat::fragment{"$name":
          target  => "/etc/mail/sendmail.mc",
          content => "define(`SMART_HOST',`smtp.ox.ac.uk')\n",
        }



}

