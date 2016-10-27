FROM tcnksm/centos-ruby:2.1
MAINTAINER oomatomo ooma0301@gmail.com

# env
ENV TZ=JST-9
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# install package
RUN yum update -y
RUN yum install -y openssh-server openssh-clients
RUN yum install -y sudo
RUN yum install -y ansible
# for ansible mysql
RUN yum install -y MySQL-python

# create user
RUN useradd -m -s /bin/bash test
RUN echo "test" | passwd test --stdin

# setup sudo config
RUN echo "test ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# tty経由の対応 "sudo: sorry, you must have a tty to run sudo"
RUN sed -ri 's/Defaults    requiretty/#Defaults    requiretty/g' /etc/sudoers

# setup ssh
RUN sed -ri 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
RUN sed -ri 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

# init sshd
RUN /etc/init.d/sshd start
RUN /etc/init.d/sshd stop

USER test

RUN mkdir /home/test/.ssh
RUN chmod 700 /home/test/.ssh
# known_hosts の対話的なやりとりを無視する
RUN echo "StrictHostKeyChecking no" >> /home/test/.ssh/config

WORKDIR /home/test/ansible-jenkins2

COPY serverspec/Gemfile serverspec/Gemfile
COPY serverspec/Gemfile.lock serverspec/Gemfile.lock
RUN bundle install --gemfile=serverspec/Gemfile
