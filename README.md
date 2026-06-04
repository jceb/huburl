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

## Installation

### Dependencies

- `nushell` for executing the script itself
- `jujutsu`/`jj` to find bookmarks and remotes in jujutsu repositories
- `git` to find branches and remotes in git repositories

### 1. Installation with Nix Flake

1. Add the `huburl` section to your
   [Flake](https://wiki.nixos.org/wiki/Flakes)'s `inputs`:

```nix
inputs = {
  # (...)
  huburl = {
    url = "github:jceb/huburl";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

2. Add the following to your `nixpkgs.overlays`:

```nix
(final: prev: {
  # (...)
  huburl = import inputs.huburl {
    inherit system;
  };
})
```

(<https://wiki.nixos.org/wiki/Overlays#Using_overlays>)

3. Rebuild your configuration and check if it works with `huburl --help`.

### 2. Manual Installation

1. Clone the repository:

```sh
git clone https://github.com/jceb/huburl
cd huburl
```

2. Make the file executable:

```sh
chmod u+x ./huburl
```

3. Execute the file from inside a git or jujutsu repository:

```sh
./huburl --help
```

You can also add the file to `$PATH` to use it anywhere.

### 3. One-time Usage with `nix run`

```sh
nix run github:jceb/huburl
```

## Configuration

The file `~/.config/huburl/config.toml` contains options for the tool.

### hubs.*

To configure a hostname to be associated with a specific hub:

```toml
[hubs.gitlab]
hostnames = [ "git.example.com" ]
```

Supported hub types: `github`, `gitlab`, `gitea`, `forgejo`, `azure`, `srht`
