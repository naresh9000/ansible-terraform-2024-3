[allservers]
testserver01 ansible_port=22 ansible_host=${testserver01} ansible_user=ansibleadmin
testserver02 ansible_port=22 ansible_host=${testserver02} ansible_user=ansibleadmin
testserver03 ansible_port=22 ansible_host=${testserver03} ansible_user=ansibleadmin

[pvt]
pvttestserver01 ansible_port=22 ansible_host=${pvttestserver01} ansible_user=ansibleadmin
pvttestserver02 ansible_port=22 ansible_host=${pvttestserver02} ansible_user=ansibleadmin
pvttestserver03 ansible_port=22 ansible_host=${pvttestserver03} ansible_user=ansibleadmin

[webservers]
testserver01 ansible_port=22 ansible_host=${testserver01} ansible_user=ansibleadmin

[appservers]
testserver02 ansible_port=22 ansible_host=${testserver02} ansible_user=ansibleadmin

[dbservers]
testserver03 ansible_port=22 ansible_host=${testserver03} ansible_user=ansibleadmin