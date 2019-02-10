class vbox_dhcp_server
{

    package { 'dhcp':
        ensure => present,
    }

    file { '/etc/dhcp/dhcpd.conf':
        ensure => present,
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/vbox_dhcp_server/etc_dhcp_dhcpd.conf',
        require => Package['dhcp'],
    }

    service { 'dhcpd':
        ensure => running,
        enable => true,
        subscribe => File['/etc/dhcp/dhcpd.conf'],
    }

}
