# mirror-data

Script for mirroring data

* Making the script executable

 `chmod u+x mirror-data.sh`

* Running with chron and additionally error log

 `35 10 * * * /home/myname/myapps/mirror-data.sh 2>> /home/myname/myapps/log/mirror-data_error.log`

* Logrotate

 Edit path to logfiles in `mirror-data-logrotate`
 and then move it to the logrotate folder, i.e. for using on rasperry pi:
 `sudo mv mirror-data-logrotate /etc/logrotate.d/mirror-data`
