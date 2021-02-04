#!/bin/sh
export INSTHOME=/SAP/DB2/PATH/TO/bin
export LOGHOME=/PATH/TO/A/FOLDER/TO/WRITE/LOGS
date >> $LOGHOME/veeam_write_suspend.log
echo "----START SUSPEND----" >> $LOGHOME/write_suspend.log << EOF
EOF
# Connect to your desired database
$INSTHOME/db2 connect to YOUR_DATABASE_NAME_HERE >> $LOGHOME/veeam_write_suspend.log
echo "+++" >> $LOGHOME/veeam_write_suspend.log << EOF_1
EOF_1
# Suspend the Logwriter for your desired database
$INSTHOME/db2 set write suspend for database >> $LOGHOME/veeam_write_suspend.log
echo "+++" >> $LOGHOME/veeam_write_suspend.log << EOF_2
EOF_2
$INSTHOME/db2pd -db YOUR_DATABASE_NAME_HERE -dbcfg | grep 'Database is in write suspend state' >> $LOGHOME/veeam_write_suspend.log
echo "----END----" >> $LOGHOME/veeam_write_suspend.log << EOF_3
EOF_3