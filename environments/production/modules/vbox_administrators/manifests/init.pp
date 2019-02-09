class vbox_administrators
{

    class { 'vbox_sudo_group':
        groupname => 'admins',
        gid => 2100,
    }

    class { 'vbox_admin_user':
        username => 'jafager',
        fullname => 'Jason A. Fager',
        uid => 1100,
        sshkey => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDBWghKioWJSTqcCfNonD8S146NK9f8cprpWGYphxr/08Uv6u/Qlei80OQsVJKy0KKowcI482/0HkHmjbcboEZM3VZvKDlpv3lt3I13rsa0o8LrltqURSoemZzSLXTw04jwpbf3KEkcoAJhczrbUwMCKlsC1PsPXJ1PjeA9cSFLcT2zJjY+Wdy4wxkyN4K1fyXtkasAEbHHrZ3u/qTZRY/ig8/oI+il9sXOZVxbieCLzJL/8tKEgaTtI9XZA7lHY+DLD1tta9+GigvCPRSYdobLnDUi2ub4eMZIuPoLg4qBA2PqazlFStZ52pHOv106V4x7mD0+fmE5ummGORw4VzE/',
    }

}
