class vbox_dhcp_server
{

    package { 'dhcp':
        ensure => present,
    }

    file { '/etc/dhcp/dhcpd.conf':
    {
        ensure => present,
        owner => root,
        group => root,
        mode => '0644',
        file => 'puppet:///modules/vbox_dhcp_server/etc_dhcp_dhcpd.conf',
        require => Package['dhcp'],
    }

}
