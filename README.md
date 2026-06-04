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
> `ssh` remotes are supported and converted to `https` automatically. Shortened
> paths such as `git@github.com:someone/repo.git` are only supported if they
> begin with `git@`.

## Dependencies

- [`nushell`](https://nushell.sh) for executing the script itself
- [`jujutsu`/`jj`](https://jj-vcs.dev/) to find bookmarks and remotes in jujutsu
  repositories
- [`git`](https://git-scm.com/) to find branches and remotes in git repositories

## Installation

### Manual Installation

```sh
curl -o /usr/local/bin/huburl https://github.com/jceb/huburl/raw/refs/heads/main/huburl
chmod u+x /usr/local/bin/huburl
cd my-repository
huburl # generates the URL to your hub
```

### Installation with Nix Flake

1. Add the `huburl` section to your
   [Flake](https://wiki.nixos.org/wiki/Flakes)'s `inputs`:

```nix
inputs = {
  # (...)
  huburl = {
    url = "github:jceb/huburl/main";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

2. Add the following to your
   [`nixpkgs.overlays`](https://wiki.nixos.org/wiki/Overlays#Using_overlays):

```nix
(final: prev: {
  # (...)
  huburl = import inputs.huburl {
    inherit system;
    inherit (prev) pkgs stdenv;
  };
})
```

3. Rebuild your configuration
   (`nixos-rebuild switch --flake your-system-config`) and check if it works
   with `huburl --help`.

4. Execute the file from inside a git or jujutsu repository:

```sh
huburl # generates the URL to your hub
```

### One-time Usage with `nix run`

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
