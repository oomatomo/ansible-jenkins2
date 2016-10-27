#! /bin/bash
bundle install --gemfile=serverspec/Gemfile
ansible-playbook ansible/jenkins.yml
#ansible-playbook ansible/jenkins-job.yml
cd ./serverspec/ && rake spec
