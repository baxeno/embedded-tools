# baxeno/embedded-tools

This container shows how to create a build environment that can be used both by CI servers and developers.
Developers would normally use `docker_workspace.sh` to bootstrap all needed docker parameters or alternative use YAML with docker-compose.
CI servers normally don't like entry-point scripts so disable it with `--entrypoint=''`.

Default seccomp can block needed system calls, so it can be handy to test with `--security-opt seccomp:unconfined`.

> :warning: Create custom seccomp profile. See [Docker secure computing mode](https://docs.docker.com/engine/security/seccomp/).

---
:unicorn: Fairy tale
---

Once upon a time Acme Corporation had a big problem with unicorn build environments.
They shipped everything from bird seeds to explosive tennis balls.
Customers loved their products which meant Acme was producing 7 different versions of anvils.
This poses a challenge since 2 are round, 4 are square and 1 is hexagon so it required
3 build environments just for anvils :hammer:.

---
Jenkins declarative pipelines
---

Example of using this docker container can be seen in [example/Jenkinsfile](example/Jenkinsfile).

**Private docker registry:**

Add `registryUrl` and `registryCredentialsId` properties under `pipeline.agent.docker` in the `Jenkinsfile`.

---
Useful links to additional documentation
---

- [How Developers are Legally Murdered](https://www.praqma.com/stories/legally-murdered-developers/)
- [How to Tag Docker Images with Git Commit Information](https://blog.scottlowe.org/2017/11/08/how-tag-docker-images-git-commit-information/)
- [Let’s make your Docker Image better than 90% of existing ones](https://medium.com/@chamilad/lets-make-your-docker-image-better-than-90-of-existing-ones-8b1e5de950d)
- [Label Schema Convention](http://label-schema.org/rc1/)
- [Docker Environment Variables: How to Set and Configure Server Applications](https://stackify.com/docker-environment-variables/)
