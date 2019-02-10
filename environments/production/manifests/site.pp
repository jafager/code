node default
{

    class { 'vbox_sudo_group':
        groupname => 'admins',
        gid => 2100,
    }

}
