#!/bin/sh
export INSTHOME=/SAP/DB2/PATH/TO/bin
export LOGHOME=/PATH/TO/A/FOLDER/TO/WRITE/LOGS
date >> $LOGHOME/veeam_write_resume.log
echo "----START RESUME----" >> $LOGHOME/veeam_write_resume.log << EOF
EOF
$INSTHOME/db2 connect to YOUR_DATABASE_NAME_HERE >> $LOGHOME/veeam_write_resume.log
echo "+++" >> $LOGHOME/veeam_write_resume.log << EOF_1
EOF_1
$INSTHOME/db2 set write resume for database >> $LOGHOME/veeam_write_resume.log
echo "+++" >> $LOGHOME/veeam_write_resume.log << EOF_2
EOF_2
echo "----END----" >> $LOGHOME/veeam_write_resume.log << EOF_3
EOF_3