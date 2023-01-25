#!/usr/bin/expect

set servers {"server1" "server2" "server3"}
set username "username"
set password "password"

foreach server $servers {
    spawn sudo openconnect $server
    expect {
        "*Enter 'yes' to accept, 'no' to abort; anything else to view: " {
            send "yes\r"
        }
        "*Username:" {
            send "$username\r"
        }
        "*Password:" {
            send "$password\r"
        }
        timeout {
            puts "*Failed to connect to $server. Trying next server."
            continue
        }
    }
	expect "*Username:" {
    	send "$username\r"
	}
	expect "*Password:" {
 		send "$password\r"
	}
    
    interact
    break
}

