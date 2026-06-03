# huburl

A tool for generating the URL of the current local repository and path in it's
source control hub.

## Usage

```sh
huburl [flags] (path)
```

```
Flags:
  -h, --help: Display the help message for this command
  -o, --open: Open URL in browser
  -c, --copy: Copy URL into the clipboard
  -r, --remote <string>: Specific remote name, defaults to the first remote
  -v, --verbose: Verbose log output
  --test: Run tests

Parameters:
  path <path>: File or directory path, defaults to root of the repository (optional)
```

> [!IMPORTANT]
> `ssh` commands are supported and converted to `https` automatically. Shortened
> paths such as `git@github.com:someone/repo.git` are only supported if they
> begin with `git@`.

## Configuration

The file `~/.config/huburl/config.toml` contains options for the tool.

### hubs.*

To configure a hostname to be associated with a specific hub:

```toml
[hubs.gitlab]
hostnames = [ "git.example.com" ]
```

Supported hub types: `github`, `gitlab`, `gitea`, `forgejo`, `azure`, `srht`
