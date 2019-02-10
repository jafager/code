class vbox_administrators
{

    group { 'admins':
        ensure => present,
        gid => 2100,
    }

    file { '/etc/sudoers.d/admins':
        ensure => present,
        owner => root,
        group => root,
        mode => '0600',
        content => '%admins ALL=(ALL) NOPASSWD: ALL',
    }

    group { 'jafager':
        ensure => present,
        gid => 1100,
    }

    user { 'jafager':
        ensure => present,
        uid => 1100,
        gid => jafager,
        groups => [
            'admins',
        ],
        comment => 'Jason A. Fager',
        home => '/home/jafager',
        shell => '/bin/bash',
        purge_ssh_keys => true,
    }

    file { '/home/jafager':
        ensure => directory,
        owner => jafager,
        group => jafager,
        mode => '0700',
        require => [
            User['jafager'],
            Group['jafager'],
        ],
    }

    file { '/home/jafager/.ssh':
        ensure => directory,
        owner => jafager,
        group => jafager,
        mode => '0700',
        require => File['/home/jafager'],
    }

    file { '/home/jafager/.ssh/authorized_keys':
        ensure => directory,
        owner => jafager,
        group => jafager,
        mode => '0700',
        require => File['/home/jafager/.ssh'],
    }

    ssh_authorized_key { 'jafager':
        ensure => present,
        user => 'jafager',
        type => 'ssh-rsa',
        key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDBWghKioWJSTqcCfNonD8S146NK9f8cprpWGYphxr/08Uv6u/Qlei80OQsVJKy0KKowcI482/0HkHmjbcboEZM3VZvKDlpv3lt3I13rsa0o8LrltqURSoemZzSLXTw04jwpbf3KEkcoAJhczrbUwMCKlsC1PsPXJ1PjeA9cSFLcT2zJjY+Wdy4wxkyN4K1fyXtkasAEbHHrZ3u/qTZRY/ig8/oI+il9sXOZVxbieCLzJL/8tKEgaTtI9XZA7lHY+DLD1tta9+GigvCPRSYdobLnDUi2ub4eMZIuPoLg4qBA2PqazlFStZ52pHOv106V4x7mD0+fmE5ummGORw4VzE/',
        require => File['/home/jafager/.ssh/authorized_keys'],
    }

    file { '/home/jafager/.hushlogin':
        ensure => present,
        owner => jafager,
        group => jafager,
        mode => '0600',
        content => '',
        require => File['/home/jafager'],
    }

}
