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

}
