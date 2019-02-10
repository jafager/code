class vbox_tftp_server
{

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
        source => 'puppet:///modules/vbox_tftp_server/etc_xinetd.d_tftp',
        require => [
            Package['xinetd'],
            Package['tftp-server'],
        ],
    }

    service { 'xinetd':
        ensure => running,
        subscribe => File['/etc/xinetd.d/tftp'],
    }

    exec { 'firewalld create tftp service':
        command => 'firewall-cmd --permanent --new-service=tftp; firewall-cmd --permanent --service=tftp --add-port=69/udp',
        path => '/bin',
        refreshonly => true,
        subscribe => Package['tftp-server'],
    }

    exec { 'firewalld add tftp service':
        command => 'firewall-cmd --permanent --add-service=tftp',
        path => '/bin',
        refreshonly => true,
        subscribe => Exec['firewalld create tftp service'],
    }

    exec { 'firewalld reload':
        command => 'firewall-cmd --reload',
        path => '/bin',
        refreshonly => true,
        subscribe => Exec['firewalld add tftp service'],
    }

    service { 'firewalld':
        ensure => running,
        enable => true,
    }

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
        source => 'puppet:///modules/vbox_tftp_server/var_lib_tftpboot_pxelinux.cfg',
        require => File['/var/lib/tftpboot/pxelinux.cfg'],
    }

}
