class vbox_dhcp_server
{

    package { 'dhcp':
        ensure => present,
    }

}
