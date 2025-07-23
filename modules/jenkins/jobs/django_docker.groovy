pipelineJob("django-docker") {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url(${github_repo_url})
            credentials("github-token")
          }
          branches("*/${github_branch}")
        }
      }
      scriptPath("Jenkinsfile")
    }
  }
}
