class vbox_admin_user (String $username, String $fullname, Integer $uid, String $sshkey)
{

    group { "${username}":
        ensure => present,
        gid => $uid,
    }

    user { "${username}":
        ensure => present,
        uid => $uid,
        gid => $username,
        groups => [
            'admins',
        ],
        comment => $fullname,
        home => "/home/${username}",
        shell => '/bin/bash',
        purge_ssh_keys => true,
        require => Group[$username],
    }

    file { "/home/${username}":
        ensure => directory,
        owner => $username,
        group => $username,
        mode => '0700',
        require => User[$username],
    }

    file { "/home/${username}/.ssh":
        ensure => directory,
        owner => $username,
        group => $username,
        mode => '0700',
        require => File["/home/${username}"],
    }

    file { "/home/${username}/.ssh/authorized_keys":
        ensure => present,
        owner => $username,
        group => $username,
        mode => '0600',
        require => File["/home/${username}/.ssh"],
    }

    ssh_authorized_key { "${username}":
        ensure => present,
        user => $username,
        type => 'ssh-rsa',
        key => "$sshkey,
        require => File["/home/${username}/.ssh"],
    }

    file { "/home/${username}/.hushlogin":
        ensure => present,
        owner => $username,
        group => $username,
        mode => '0600',
        content => '',
        require => File["/home/${username}"],
    }

}
