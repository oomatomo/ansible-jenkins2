# ansible-jenkins2

[![Build Status](https://travis-ci.org/oomatomo/ansible-jenkins2.svg?branch=master)](https://travis-ci.org/oomatomo/ansible-jenkins2)

## setup

```
docker-compose build dev
ssh -p 2222 test@127.0.0.1
password: test
ansible-playbook ansible-jenkins2/ansible/jenkins.yml
```

`http://127.0.0.1/`にアクセスする

```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Admin用のユーザーを作成する
username: test
password: test

Adminユーザーの鍵を作成

```
sudo -u jenkins ssh-keygen -t rsa -C jenkins
```

GUIでAdminユーザーの公開鍵を設定する
http://127.0.0.1/user/test/configure
SSH Public Keysの項目
鍵は、上で作った公開鍵でおk

```
cat /var/lib/jenkins/.ssh/id_rsa.pub
```

ジョブを作成する
```
ansible-playbook ansible-jenkins2/ansible/jenkins-job.yml
```

