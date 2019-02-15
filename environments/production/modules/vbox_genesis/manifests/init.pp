class vbox_genesis
{

    ###
    ### DHCP
    ###

    package { 'dhcp':
        ensure => present,
    }

    file { '/etc/dhcp/dhcpd.conf':
        ensure => present,
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/vbox_genesis/etc_dhcp_dhcpd.conf',
        require => Package['dhcp'],
    }

    service { 'dhcpd':
        ensure => running,
        enable => true,
        subscribe => File['/etc/dhcp/dhcpd.conf'],
    }

    ###
    ### TFTP
    ###

    package { 'tftp-server':
        ensure => present,
    }

    package { 'syslinux-tftpboot':
        ensure => present,
        require => Package['tftp-server'],
    }

    package { 'xinetd':
        ensure => present,
    }

    file { '/etc/xinetd.d/tftp':
        ensure => present,
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/vbox_genesis/etc_xinetd.d_tftp',
        require => [
            Package['xinetd'],
            Package['tftp-server'],
        ],
    }

    service { 'xinetd':
        ensure => running,
        subscribe => File['/etc/xinetd.d/tftp'],
    }

    ###
    ### PXE
    ###

    file { '/var/lib/tftpboot/pxelinux.cfg':
        ensure => directory,
        owner => root,
        group => root,
        mode => '0755',
        require => Package['syslinux-tftpboot'],
    }

    file { '/var/lib/tftpboot/pxelinux.cfg/default':
        ensure => present,
        owner => root,
        group => root,
        mode => '0644',
        source => 'puppet:///modules/vbox_genesis/var_lib_tftpboot_pxelinux.cfg_default',
        require => File['/var/lib/tftpboot/pxelinux.cfg'],
    }

    ###
    ### HTTP
    ###

    package { 'httpd':
        ensure => present,
    }

    service { 'httpd':
        ensure => running,
        enable => true,
        require => Package['httpd'],
    }

    ###
    ### firewalld
    ###

    exec { 'firewalld add tftp service':
        command => 'firewall-cmd --permanent --add-service=tftp',
        path => '/bin',
        refreshonly => true,
        subscribe => Package['tftp-server'],
    }

    exec { 'firewalld add http service':
        command => 'firewall-cmd --permanent --add-service=http',
        path => '/bin',
        refreshonly => true,
        subscribe => Package['httpd'],
    }

    exec { 'firewalld reload':
        command => 'firewall-cmd --reload',
        path => '/bin',
        refreshonly => true,
        subscribe => [
            Exec['firewalld add tftp service'],
            Exec['firewalld add http service'],
        ],
    }

    service { 'firewalld':
        ensure => running,
        enable => true,
    }

}
