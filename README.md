# Openelec addons by Viljo Viitanen

## How to use:

* first check out openelec git repository
* then copy this repo contents over there

## Contents

### Mysql server ###

Hack to get mysql server service addon in OpenELEC.
To compile and create addon
    ./scripts/create_addon mysql-server

For now this messes up the build system so after making the addon
you need to clean up at least the mysql build dir.

### FCEUX

A Nintendo emulator. http://fceux.org

Adds also scons build system

Not really complete yet, just provides a binary and no means to launch roms. For now use e.g. advanced launcher addon to launch.

### Scons

http://scons.org - used in fceux build.

### Notes

This is intentionally not a forked openelec repo!
