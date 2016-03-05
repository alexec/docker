# Docker

Use Java >= 7.

To get started:

    ./builder.sh init build

To re-provision build servers:

    ansible-playbook -i inventory build-servers.yml configure-git.yml configure-maven.yml

Manually add SSH key:

  https://help.github.com/articles/generating-an-ssh-key/
  https://github.com/settings/ssh

Releases:

    ansible-playbook -i inventory  release-docker-java-orchestration.yml release-docker-maven-plugin.yml
