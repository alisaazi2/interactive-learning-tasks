Role Name
=========

Installs wordpress on Ubuntu and Amazon-Linux
Creates group called devops with admin privileges
Adds users to devops group


Role Variables
--------------

wordpress_version: "4.0.32"  # for Amazon
php_version: "5.4.16"    # for Amazon
users: 
  - Ben
  - Lisa
  - Katty
  - Boots
  - Rachel

Dependencies

Example Playbook
----------------

- name: execute role
  hosts: all
  become: yes
  become_method: sudo 
  roles:
    - wordpress
License
-------

BSD

Author Information
------------------
