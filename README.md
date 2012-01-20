# Openelec addons by Viljo Viitanen

How to use:

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

2.0.1 download adds a file dialog to choose the launched rom  
To quit the emulator, press the delete key

TODO:
fix ccache directory, now it does not use openelec build specific cache directory, but default $HOME/.ccache  
add command line parameters to settings instead of hardcoded values  

To compie and create addon
    ./scripts/create_addon fceu

Adds also scons build system, below

### Scons

http://scons.org - used in fceux build.

### Notes

This is intentionally not a forked openelec repo!
