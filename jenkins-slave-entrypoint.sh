#!/bin/bash

# if `docker run` first argument start with `-` the user is passing jenkins swarm launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "-"* ]]; then

  # jenkins swarm slave
  JAR=`ls -1 /usr/share/jenkins/swarm-client-*.jar | tail -n 1`

  JAVA_HOME=$JENKINS_JAVA_HOME

  # if -master is not provided and using --link jenkins:jenkins
  if [[ "$@" != *"-master "* ]] && [ ! -z "$JENKINS_PORT_8080_TCP_ADDR" ]; then
    PARAMS="-master http://$JENKINS_PORT_8080_TCP_ADDR:$JENKINS_PORT_8080_TCP_PORT"
  fi

  CMD="$JAVA_HOME/bin/java $JAVA_OPTS -jar $JAR -fsroot $JENKINS_SLAVE_HOME $PARAMS $@"
  echo "Running $CMD"
  exec su jenkins_slave -c "$CMD"
fi

# As argument is not jenkins, assume user want to run his own process, for sample a `bash` shell to explore this image
exec "$@"
