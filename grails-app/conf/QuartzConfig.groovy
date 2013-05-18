quartz {
  autoStartup = true
}

environments {
  test {
    quartz {
      autoStartup = false
    }
  }

  development {
    quartz {
      autoStartup = true
      waitForJobsToCompleteOnShutdown = false

    }
  }


}
