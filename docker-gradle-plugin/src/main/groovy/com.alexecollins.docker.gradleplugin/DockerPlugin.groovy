package com.alexecollins.docker.gradleplugin

import org.gradle.api.Plugin
import org.gradle.api.Project

class DockerPlugin implements Plugin<Project> {
    void apply(Project project) {
        project.task('validate', type: ValidateTask)
    }
}