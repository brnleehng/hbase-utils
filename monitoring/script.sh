#!/bin/bash

wget https://github.com/Microsoft/OMS-Agent-for-Linux/releases/download/OMSAgent_GA_v1.2.0-25/omsagent-1.2.0-25.universal.x64.sh -O /tmp/omsagent.x64.sh
sudo sh /tmp/omsagent.x64.sh --upgrade -w $1 -s $2

sudo wget https://raw.githubusercontent.com/brnleehng/hbase-utils/feature/batch-oms/monitoring/batch.workernode.conf -O /etc/opt/microsoft/omsagent/conf/omsagent.d/batch.workernode.conf

sudo wget https://raw.githubusercontent.com/brnleehng/hbase-utils/feature/batch-oms/monitoring/filter_batch.rb -O /opt/microsoft/omsagent/plugin/filter_batch.rb

sudo wget https://raw.githubusercontent.com/brnleehng/hbase-utils/feature/batch-oms/monitoring/batchmanifestreader.rb -O  /opt/microsoft/omsagent/bin/batchmanifestreader.rb
sudo wget https://raw.githubusercontent.com/brnleehng/hbase-utils/feature/batch-oms/monitoring/omsagent
sudo cp omsagent /etc/sudoers.d/
sudo sh -x /opt/microsoft/omsagent/bin/omsadmin.sh -w $1 -s $2
sudo service omsagent restart
