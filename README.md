<p align="center">
    <a href="https://github.com/DevelopersToolbox/">
        <img src="https://cdn.wolfsoftware.io/assets/images/github/organisations/developerstoolbox/black-and-white-circle-256.png" alt="DevelopersToolbox logo" />
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/github-repo-stats/actions/workflows/ci.yml">
        <img src="https://img.shields.io/github/workflow/status/DevelopersToolbox/github-repo-stats/ci/master?style=for-the-badge" alt="Github Build Status">
    </a>
    <a href="https://github.com/DevelopersToolbox/github-repo-stats/releases/latest">
        <img src="https://img.shields.io/github/v/release/DevelopersToolbox/github-repo-stats?color=blue&label=Latest%20Release&style=for-the-badge" alt="Release">
    </a>
    <a href="https://github.com/DevelopersToolbox/github-repo-stats/releases/latest">
        <img src="https://img.shields.io/github/commits-since/DevelopersToolbox/github-repo-stats/latest.svg?color=blue&style=for-the-badge" alt="Commits since release">
    </a>
    <br />
    <a href=".github/CODE_OF_CONDUCT.md">
        <img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge" />
    </a>
    <a href=".github/CONTRIBUTING.md">
        <img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge" />
    </a>
    <a href=".github/SECURITY.md">
        <img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/github-repo-stats/issues">
        <img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge" />
    </a>
    <br />
    <a href="https://wolfsoftware.io/">
        <img src="https://img.shields.io/badge/Created%20by%20Wolf%20Software-blue?style=for-the-badge" />
    </a>
</p>

## Overview

Ghstats is a small command line tool to retrieve a set of stats for a given set of repositories, It allows you to get stats for all repositories owned by a named user or users, or from an organisation or organisations.

To make the reporting as fast as possible we make extensive use of the [Parallel](https://rubygems.org/gems/parallel) gem to run as many clones as possible in parallel.

### Tokens

There is no requirement to supply a token when using ghstats, however there are numerous benefits. including but not limited to:

1. Less impact from connection throttling (Unauthenticated connections are throttled more heavily by GitHub)
2. Ability to get stats for private repositories
3. Simple to report on all of your own repositories (no need to specify a username)

You could for example get stats for ALL the repositories that you own with a single command.

```
# ghstats -t <Your token goes here> -A
```

> If you just wanted your personal repositories you could use -U instead of -A, or -M if you just wanted the repositories for organisations that you are a member of.

If you do not supply token you will be limited to reporting on just public repositories.

### No Passwords?

We intentionally do **NOT** handle username + password combinations when talking to GitHub, this removes some security risks and also removes the issue of having to handle MFA logins. It allows you to create a `read-only` token for cloning only to further improve your security position.

### Example

The following is an example of how to get stats about all **public** repositories owned by Wolf Software.

```shell
# ghstats -o WolfSoftware
```

## Usage

```shell
Usage: ghstats
    -h, --help                       Display this screen

Access Parameters:
    -t, --token <token>              GitHub personal access token (PAT)

Report Parameters:
    -u, --user <names>               Github username(s) to rip
    -o, --org <names>                Github organisation(s) to rip
    -U, --user-repos                 Rip all of the repositories for the named user(s)
    -M, --org-member-repos           Rip all of the repositories for all organisation the user(s) is a member of
    -A, --all-repos                  Same as running -U -M
    -O, --org-repos                  Rip all of the repositories for the named organisation(s)

Report Flags:
    -P, --public-only                Only use public repos
```

> If you just supply a username and nothing else it will default to just the users own repositories (same as -U)

### Default Values

| Option Name            | Default Value  | Purpose |
| ---------------------- | -------------- | ------- |
| -t, --token            | No default     | The token used to authenticate yourself (not required but helps remove/mitigate throttling issues) | 
| -u, --user             | No default     | The user(s) you wish to rip the repo of (if not supplied defaults to yourself **IF** a token is used) |
| -o, --org              | No default     | The organisation(s) you want to rip the repos of |
| -U, --user-repos       | False          | Download all repositories belonging to the named user(s) |
| -M, --org-member-repos | False          | Download all repositories belonging to any organisation the named user(s) is a member of |
| -A, --all-repos        | False          | Works the same as --user-repo and --org-member-repos combined |
| -O, --org-repos        | False          | Download all repositories belonging to the named organisation(s) |
| -P, --public-only      | False          | Only display stats for public repos (default is all visible repos - includes private if a token is supplied) |

> users and orgs can be either a single entry or comma-separated list of entries.

### Error Handling

All errors raised from github-core-lister are caught and re-thrown as StandardErrors in order to simplify the catching.
