class vbox_sudo_group (String $groupname, Integer $gid)
{

    group { $groupname:
        ensure => present,
        gid => $gid,
    }

    file { "/etc/sudoers.d/${groupname}":
        ensure => present,
        owner => root,
        group => root,
        mode => '0600',
        content => "%${groupname} ALL=(ALL) NOPASSWD: ALL",
    }

}
