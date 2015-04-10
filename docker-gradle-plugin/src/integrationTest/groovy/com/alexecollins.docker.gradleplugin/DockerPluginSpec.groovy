package com.alexecollins.docker.gradleplugin


abstract class DockerPluginSpec extends IntegrationSpec {

    def "working"() {
        setup:
        buildFile << """
			apply plugin: 'docker'

            repositories {
                maven {
                    url "${localRepoUri}"
                    mavenCentral()
                }
            }
            dependencies {
                classpath 'com.alexecollins.docker.gradleplugin:gradle-plugin:latest'
            }
		"""

        when:
        println "YES!"

        then:
        assert false
    }
}
