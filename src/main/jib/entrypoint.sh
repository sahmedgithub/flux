#!/bin/sh

echo "The application will start in ${APPLICATION_SLEEP}s..." && sleep ${APPLICATION_SLEEP}
exec java ${JAVA_OPTS} -noverify -XX:+AlwaysPreTouch -Djava.security.egd=file:/dev/./urandom -cp /app/resources/:/app/classes/:/app/libs/* "com.homedepot.ame"  "$@"
