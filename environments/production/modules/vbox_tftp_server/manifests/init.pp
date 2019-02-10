class vbox_tftp_server
{

    package { 'tftp-server':
        ensure => present,
    }

    package { 'syslinux-tftpboot':
        ensure => present,
        require => Package['tftp-server'],
    }

}
