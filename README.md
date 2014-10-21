# logstash-indexer-juju-charm

Juju Charm for logstash agent.

will download the logastash monolithic.jar every time unless you have a copy in files/charm/

common.sh provides a bunch of config stuff bits ... useful to customize locations etc.


Inputs
: File  -  /var/log/syslog and some others
Outputs
: Redis -  configured to use redis as a message bus to logstash server


needs to join relationship with logstash-indexer to do anything useful, although it will output to a text file without for testing/debug purposes.

will search for known local log files and add logstash inputs for them.   This means if you add it to an apache server it will find the /var/log/apache2 directory and start sucking down logs from that dir.

# Configuration:

mid-flight configurable variables found in config.yaml.     modify Reload to get it to rescan server for known log files.   Add custom log inputs,  Add twitter keyword input.

pre-flight configuration variables found in hooks/common.sh  ...  don't change these unless you know what you're doing.

# Examples:

*see logstash-indexer charm's README.md file for usage examples showing the full charm stack.*

## secure Kibana with auth-proxy and log it's apache configs

*strong example delivers basic logstash-indexer stack also*

    # deploy Kibana Charm
    juju deploy kibana
    # deploy Auth-Proxy subordinate charm to kibana
    juju deploy --repository=examples local:precise/auth-proxy
    juju add-relation auth-proxy kibana
    juju set auth-proxy ServerAdmin="kibana@example.com" ServerName="kibana.example.com" DestinationURL="http://127.0.0.1:5601/"
    # deploy logstash-indexer and connect Kibana to it.
    juju deploy logstash-indexer
    juju add-relation kibana logstash-indexer:rest
    # deploy Logstash-Indexer subordinate charm to kibana and connect it to Logstash-Indexer
    juju deploy --repository=logstash local:precise/logstash-agent
    juju add-relation logstash-agent kibana
    juju add-relation logstash-agent:input logstash-indexer:input


## Log Twitter mentions of logstash, devops, ubuntu

*weak example for demo purposes,  really need to connect to logstash-indexer and kibana etc to be useful.*

    juju deploy ubuntu
    juju deploy --repository=logstash local:precise/logstash-agent
    juju add-relation logstash-agent ubuntu
    juju set logstash-agent InputTwitterEnabled=true InputTwitterUsername="derpaderp" InputTwitterPassword="wallybollysollynolly" InputTwitterKeywords="['logstash','devops','ubuntu']"

## Read apt package manager log files

*weak example for demo purposes,  really need to connect to logstash-indexer and kibana etc to be useful.*

    juju deploy ubuntu
    juju deploy --repository=logstash local:precise/logstash-agent
    juju add-relation logstash-agent ubuntu
    juju set logstash-agent CustomLogFile="['/var/log/apt/term.log','/var/log/apt/history.log']" CustomLogType="apt"


