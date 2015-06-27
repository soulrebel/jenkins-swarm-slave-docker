# Jenkins swarm slave

Based on [`csanchez/jenkins-swarm-slave`](https://registry.hub.docker.com/u/csanchez/jenkins-swarm-slave/),

An extendable [Jenkins swarm](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin)
slave base to work with a [`Jenkins master`](https://registry.hub.docker.com/u/csanchez/jenkins-swarm-slave/).

## Running

Just use Docker run with any argument the slave
[accepts](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin#SwarmPlugin-AvailableOptions):

    docker run aratto/jenkins-swarm-slave -master http://jenkins:8080 -username jenkins -password jenkins -executors 1

Linking to the Jenkins master container there is no need to use `--master`

    docker run -d --name jenkins -p 8080:8080 csanchez/jenkins-swarm
    docker run -d --link jenkins:jenkins aratto/jenkins-swarm-slave -username jenkins -password jenkins -executors 1

## Extending

Start your Dockerfile with `FROM aratto/jenkins-swarm-slave` and add your own
build tools.

When running be sure to pass relevant `-labels` options to manage what types of
build will be serviced.
