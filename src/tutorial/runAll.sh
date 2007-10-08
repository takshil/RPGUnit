#!/bin/sh
for step in `ls -d step* | sort -k 1.5 -n`
do
	echo Handling "$step"
	for fileMember in `ls "$step"/*.MBR 2>/dev/null`
	do
		ncftpput -u "$RPGUNIT_USR" -p "$RPGUNIT_PWD" -aR "$RPGUNIT_HOST" /QSYS.LIB/"$RPGUNIT_LIB".LIB/RUTUTORIAL.FILE "$fileMember"
	done
	rmtcmd /SYSTEM:"$RPGUNIT_HOST" /USER:"$RPGUNIT_USR" /PASSWORD:"$RPGUNIT_PWD" /Z /Q /I:"$step"/runAfter.cl
done
