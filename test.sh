#! /bin/bash
bundle install --gemfile=serverspec/Gemfile
ansible-playbook ansible/jenkins.yml
#ansible-playbook ansible/jenkins-job.yml
sleep 60
cd ./serverspec/ && rake spec
