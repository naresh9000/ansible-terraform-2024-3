list the target hosts commands::
ansible -i invfile pvt --list-hosts


**add_host module**
The add_host module in Ansible is used to dynamically add or create host entries(inventory) during the execution of a playbook. This module is particularly useful when you need to add hosts dynamically based on certain conditions or variables within your playbook.

```
- name: Add host with variables
  hosts: localhost
  vars:
    new_host_name: "custom_host"
    new_host_ip: "192.168.1.100"
  tasks:
    - name: Add host with variables
      add_host:
        name: "{{ new_host_name }}"
        groups: "custom_group"
        ansible_host: "{{ new_host_ip }}"

```

scenario of CI/CD
```
---
- name: Provision and Configure New Servers
  hosts: localhost
  tasks:
    - name: Provision new servers (simulated)
      # Your actual provisioning steps would go here
      # This could involve using Terraform, AWS CLI, or any other provisioning tool
      # For simplicity, we'll just simulate the creation of two new servers
      set_fact:
        new_servers:
          - name: "webserver1"
            ip: "192.168.1.101"
          - name: "webserver2"
            ip: "192.168.1.102"

    - name: Add new servers to inventory
      add_host:
        name: "{{ item.name }}"
        groups: "web_servers"
        ansible_host: "{{ item.ip }}"
      with_items: "{{ new_servers }}"

- name: Deploy Application to New Servers
  hosts: web_servers
  tasks:
    - name: Copy application code
      # Your actual deployment steps would go here
      # For simplicity, we'll just simulate copying application code
      debug:
        msg: "Copying application code to {{ inventory_hostname }}"

```

**set_fact**

set_fact module is useful when you need to dynamically create or update variables based on the output of tasks, facts, or other dynamic information during the execution of an Ansible playbook.

For your clear understanding...
```
---
- name: Set Facts Example
  hosts: localhost
  tasks:
    - name: Simulate a task that produces some result
      command: echo "This is a simulated result"
      register: simulated_result

    - name: Set a fact based on the result
      set_fact:
        new_variable: "{{ simulated_result.stdout }}"

    - name: Display the new variable
      debug:
        var: new_variable

```


**VARIABLES**
we use variables to store and retrieve data. Variables can be defined at various levels, such as in playbooks, inventory files, group variables, host variables, and even dynamically during playbook execution.

```define variables directly within a playbook
---
- name: Use Variables in Playbook
  hosts: localhost
  vars:
    variable_name: "some_value"
  tasks:
    - name: Display Variable
      debug:
        var: variable_name

```


```defined in inventory files or group_vars/host_vars directories.
# inventory.ini
[servers]
server1 ansible_host=192.168.1.101

[servers:vars]
server_variable= "some_value"

@@@playbook
---
- name: Use Variables from Inventory
  hosts: servers
  tasks:
    - name: Display Variable from Inventory
      debug:
        var: server_variable


```


```register the output of a task and use it as a variable in subsequent tasks
---
- name: Register Output as Variable
  hosts: localhost
  tasks:
    - name: Run a command
      command: "echo 'Hello, World!'"
      register: command_output

    - name: Display Registered Variable
      debug:
        var: command_output.stdout

```

```gathers facts about remote systems during playbook execution.
---
- name: Use Facts as Variables
  hosts: localhost
  tasks:
    - name: Display Ansible Facts
      debug:
        var: ansible_facts

```

```CI/CD use case
---
- name: CI/CD Pipeline for Kubernetes
  hosts: localhost
  gather_facts: false
  vars:
    app_name: "my-web-app"
    docker_registry: "docker.io/myregistry"
    k8s_namespace: "production"
    k8s_deployment_name: "web-app-deployment"
    k8s_service_name: "web-app-service"
    app_version: "v1.0"

  tasks:
    - name: Build Docker Image
      shell: "docker build -t {{ docker_registry }}/{{ app_name }}:{{ app_version }} ."
      changed_when: "'Successfully built' in result.stdout"

    - name: Push Docker Image to Registry
      shell: "docker push {{ docker_registry }}/{{ app_name }}:{{ app_version }}"
      changed_when: "'{{ docker_registry }}/{{ app_name }}:{{ app_version }}' in result.stdout"

    - name: Deploy to Kubernetes
      k8s:
        state: "latest"
        definition: "{{ playbook_dir }}/k8s_manifests/deployment.yaml"
        namespace: "{{ k8s_namespace }}"
      register: k8s_result

    - name: Expose Service
      k8s:
        state: "present"
        definition: "{{ playbook_dir }}/k8s_manifests/service.yaml"
        namespace: "{{ k8s_namespace }}"
      when: k8s_result|success

```
project-directory structure
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
project_root/
│
├── ci_cd.yml
│
└── k8s_manifests/
    ├── deployment.yaml
    └── service.yaml


**when** statement is used to add conditional logic to a task. It allows you to control whether or not a particular task should be executed based on the outcome of a condition.

for ex::
```
---
- name: Example Playbook with Complex 'when' Statement
  hosts: localhost
  gather_facts: false

  vars:
    environment: "production"
    deployment_enabled: true

  tasks:
    - name: Deploy Application in Production
      debug:
        msg: "Deploying application to production"
      when: environment == "production" and deployment_enabled


```


```CI/CD use case
---
- name: Deploy App to Kubernetes
  hosts: <inventory-group-name>
  gather_facts: false

  vars:
    environment: "production"

  tasks:
    - name: Deploy Kubernetes Deployment
      k8s:
        state: present
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: my-app
          spec:
            replicas: 3
            template:
              metadata:
                labels:
                  app: my-app
              spec:
                containers:
                  - name: my-app-container
                    image: my-app:latest
      when: environment == "production"

```

```when statement used in the list
---
- name: Complex Kubernetes Deployment
  hosts: kubernetes_nodes
  become: true

  vars:
    deploy_web_app: true
    deploy_api_app: false
    deploy_db_app: true

  tasks:
    - name: Deploy Web Application
      debug:
        msg: "Deploying Web Application"
      when: deploy_web_app

    - name: Deploy API Application
      debug:
        msg: "Deploying API Application"
      when: deploy_api_app

    - name: Deploy Database Application
      debug:
        msg: "Deploying Database Application"
      when: deploy_db_app

    - name: Deploy Monitoring Stack
      debug:
        msg: "Deploying Monitoring Stack"
      when: deploy_web_app and deploy_api_app

    - name: Deploy Logging Stack
      debug:
        msg: "Deploying Logging Stack"
      when: deploy_api_app or deploy_db_app


```

** "|"-multiline string accepted and ">" folding string preserved sybols  **

For ex::
```
- name:  install aws cli
  shell: |
    sudo apt install awscli
    aws --version

    so if we use > in place of |
    it reads like folded string "sudo apt install awscli aws --version" which treats as wrong
  env: >
      - name: ENV_VAR_1
        value: "value1"
      - name: ENV_VAR_2
        value: "value2"
    
```

