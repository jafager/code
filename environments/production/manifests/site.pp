node default
{

    class { 'vbox_administrators':
    }

}

node genesis.jafager.vbox
{

    class { 'vbox_administrators':
    }

    class { 'vbox_dhcp_server':
    }

}
