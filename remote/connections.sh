# TODO: Set home folder as variable.
/usr/bin/sudo /opt/local/bin/autossh -M 0 -q -N -f -i /Users/ppm/.ssh/id_rsa.pub -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -L 80:127.0.0.1:80 ppm@juicebox
/opt/local/bin/autossh -M 0 -q -N -f -i /Users/ppm/.ssh/id_rsa.pub -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -R 8377:127.0.0.1:8377:127.0.0.1 ppm@juicebox
