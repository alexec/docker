# Docker

Use Java >= 7.

To get started:

    ./builder.sh init build
    
To re-provision build servers:

Manually add SSH key:

    https://github.com/settings/ssh

    ansible-playbook -i inventory build-servers.yml configure-git.yml configure-maven.yml
    
   