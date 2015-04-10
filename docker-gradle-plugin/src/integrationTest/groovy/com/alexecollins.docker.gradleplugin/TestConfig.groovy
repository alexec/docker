package com.alexecollins.docker.gradleplugin

class TestConfig {

    Properties testConfigProperties

    TestConfig() {
        testConfigProperties = new Properties()
        def testConfigResourcePath = '/test-config.properties'
        def testConfigResourceStream = getClass().getResourceAsStream(testConfigResourcePath)
        testConfigProperties.load(testConfigResourceStream)
    }

    String getLocalRepoUri() {
        testConfigProperties.getProperty('localRepo.uri')
    }
}
