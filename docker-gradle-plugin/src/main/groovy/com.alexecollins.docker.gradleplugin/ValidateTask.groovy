package com.alexecollins.docker.gradleplugin

import com.alexecollins.docker.orchestration.DockerOrchestrator
import org.gradle.api.DefaultTask
import org.gradle.api.tasks.TaskAction

class ValidateTask extends DefaultTask {

    @TaskAction
    def validate() {
        def dockerOrchestrator = DockerOrchestrator
                .builder()
                .build()

        dockerOrchestrator.validate()
    }

}
