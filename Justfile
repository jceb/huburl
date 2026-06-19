#!/usr/bin/env -S just --list --justfile
# Documentation: https://just.systems/man/en/

import '.justlib/default.just'
import '.justlib/bump.just'

# Print this help
default:
    @just -l

# Sets new version in files files, called by `just bump`
[group('ci')]
[private]
_bump_files CURRENT_VERSION NEW_VERSION:
    #!/usr/bin/env nu
    let current_version = "{{ CURRENT_VERSION }}"
    let new_version = "{{ NEW_VERSION }}"
