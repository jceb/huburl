# huburl

A tool for generating the (git)hub URLs from your local repository.

## Use Cases

- Share precise URLs to files, directories and repositories with friends or
  co-workers
- Speed up your personal workflows when working with multiple repositories
  across different hubs

## Features

- Generates file, file+line, directory and repository URLs
- Discovers the current branch and adds it to the URL
- Supports multiple remotes
- Supported (git)hubs: Github, Gitlab, Gitea, Forgejo, Azure DevOps, SourceHut
- Supports private hubs via a custom configuration
- 3 actions: print, copy or open URLs
- Supports [git](https://git-scm.com) and [jujutsu](https://jj-vcs.dev/)
- Work in Progress: Generate Pull Request URLs

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
- `xsel` for copying URLs (Linux)
- `xdg-open` for opening URLs (Linux)

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
    inherit (prev) pkgs;
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

### Vim Integration

Add this snippet to your vimrc to add a `:Huburl` command:

```vim
" Print the (git)hub's URL for the current file
" <bang> behaves like -o and opens then URL
" Manually pass arguments to :Huburl, e.g. -o to open the URL or -c to copy it to the clipboard
function! Huburl(bang, args)
    let l:args = a:args
    if a:bang == "!"
        let l:args = l:args.' -o'
    end
    let l:file = expand('%:p')
    let l:line = ":".line('.')
    if !l:file
        let l:file = getcwd()
        let l:line = ""
    end
    exec '!huburl '.fnameescape(l:file).l:line.' '.l:args
endfunction
command! -nargs=* -complete=file -bang Huburl :call Huburl("<bang>", <q-args>)
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
