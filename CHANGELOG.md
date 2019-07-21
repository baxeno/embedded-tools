# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2019-07-xx [Unreleased]
### Fixed
- PS1 line wrapping.
### Changed
- Base image version bump to `fedora:30` (from 29).


## [0.1.0] - 2019-04-21
### Added
- Based on `fedora:29` base image.
- Include `ptxdist-2018.12.0` and `ptxdist-2019.04.0`.
- Use `su-exec` to switch user and group id, setgroups and exec.
- Docker labels based on [Label Schema Convention](http://label-schema.org/rc1/).
- Dockerfile linting by [hadolint](https://github.com/hadolint/hadolint).
- Examples for Jenkins, Gradle and Bash.