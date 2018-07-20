# mirror-data

Script for mirroring data

* Making the script executable

    `chmod u+x mirror-data.sh`

* Running with chron and additionally error log

    `35 10 * * * /home/myname/mirror-data/mirror-data.sh 2>> /home/myname/mirror-data/log/mirror-data_error.log`

* Logrotate

 * Edit path to logfiles in `mirror-data-logrotate`

 * Then move it to the logrotate folder, i.e. for using on rasperry pi:

    `sudo mv mirror-data-logrotate /etc/logrotate.d/mirror-data`

* Change owner to root

    `sudo chown root:root /etc/logrotate.d/mirror-data`
