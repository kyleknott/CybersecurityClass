## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

(Images/Network_Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML playbook file may be used to install only certain pieces of it, such as Filebeat.

  ---
- name: Configure Elk VM with Docker
  hosts: elk
  remote_user: azadmin
  become: true
  tasks:
    # Use apt module
    - name: Install docker.io
      apt:
        update_cache: yes
        name: docker.io
        state: present

      # Use apt module
    - name: Install pip3
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

      # Use pip module
    - name: Install Docker python module
      pip:
        name: docker
        state: present

      # Use sysctl module
    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: "262144"
        state: present
        reload: yes

      # Use docker_container module
    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        published_ports:
          - 5601:5601
          - 9200:9200
          - 5044:5044

      # Use systemd module
    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes


This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound access to the network. Traffic to the vulnerable web servers will be shared, ensured by the load balancer. The Jump-Box has access controls in place that only allow authorized users to connect.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the virtual machines and system metrics.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump-Box | Gateway  | 10.0.0.4   | Linux            |
| Web-1    |Web Server| 10.0.0.6   | Linux            |
| Web-2    |Web Server| 10.0.0.7   | Linux            |
| ELK      | Monitor  | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
174.218.133.8 (Whitelisted IP's are constantly changing due to changing IP on home network)

Machines within the network can only be accessed by each other.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump-Box | Yes                 | 174.218.133.8        |
| Web-1,2  | No                  | 10.0.0.1-254         |
| ELK      | No                  | 10.0.0.1-254         |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which leaves little room for error, such as syntax problems. It also allows the entire configuration to be launched in one easy command.

The playbook implements the following tasks:
- The playbook first installs Docker.io, pyhton3-pip, and a Docker python module.
- Next, the playbook uses a systemctl command to allow it to use more memory, and downloads and launches a docker elk container.
- Last, the playbook sets up docker on boot.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

(Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
Web-1: 10.0.0.6
Web-2: 10.0.0.7
DVWA-VM2: 10.0.0.8

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat watches for changes to the file systems of the VM's.
- Metricbeat keeps an eye on metrics, such as CPU/RAM usage and failed login attempts.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook file to Control Node.
- Update the hosts file to include the [webservers] IP addresses.
- Run the playbook, and navigate to the VM's through SSH to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- The playbook, "install-elk.yml" can be copied using Git.
- Update the hosts file to make Ansible run the playbook on a specific machine.
- After giving ELK five minutes to start up, run curl http://10.0.0.8:5601 to verify that instalation was a success.
