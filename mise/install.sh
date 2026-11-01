#!/usr/bin/env bash
set -ex

# update plugins
mise plugin update

# install tools
mise install

# update tools
mise up

# remove versions no longer referenced by any config
mise prune --yes
