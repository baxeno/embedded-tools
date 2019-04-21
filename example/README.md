# Example product

Create a new git repository with files from this directory.

**Support:**

- CI: Jenkins declarative pipeline in docker environment.
- Build tools: Gradle (wrapper).
- Developer: Volume mount workspace (git repo) into docker environment.
- Docker image and version configuration in `gradle.properties` and load properties in:
  - `docker_workspace.sh`
  - `Jenkinsfile`
