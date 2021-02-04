#!/bin/sh
# MIT License
# Copyright (c) 2021 Falko Banaszak
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
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