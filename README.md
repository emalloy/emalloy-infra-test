### emalloy-infra-test


#### Prerequisites

* Backup any exisiting `~/.aws/credentials` file
* Create new `~/.aws/credentials` file in standard format
* have terraform and awscli installed

#### Invocation

* `./launch.sh`
  * launches terraform
  * applies two modules, aws/vpc + ec2
  * creates instances along with its prereqs, inside asg(1(min/max))
  * waits 30 seconds and returns public ip of instance in ASG
* `./destroy.sh`
  * destroy asg and all other created assets (destroy vpc and recurse on down)

