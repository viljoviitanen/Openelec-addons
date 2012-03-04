# Openelec unofficial addon repository

How to use:

* first check out openelec git repository
* then copy this repo contents over there
* or just use make-repo.sh to build all addons

## Addons maintained by Viljo Viitanen

### Mysql server ###

Hack to get mysql server service addon in OpenELEC.
To compile and create addon  
    ./scripts/create_addon mysql-server

For now this messes up the build system so after making the addon
you need to clean up at least the mysql build dir.

*NOT WORKING CURRENTLY, THIS NEEDS CHANGES IN OPENELEC BOOT SCRIPTS*

### FCEUX

A Nintendo emulator. http://fceux.org

2.0.2 download adds a setting for command line parameters
To quit the emulator, press the delete key

TODO:  
- fix ccache directory, now it does not use openelec build specific cache directory, but default $HOME/.ccache  

To compile and create addon  
    ./scripts/create_addon fceu

Adds also scons build system, below

### Scons

http://scons.org - used in fceux build.

### MAME

Doesn't build automatically. Compile MAME first manually from source with native
on host (32- or 64-bit), first applying the patch included which removes
gnome and xinerama references. After that build mame addon for the architecture
you built native mame for. To build 32-bit mame on 64-bit host, you need
to create e.g. a 32-bit chroot environment.

## Other addons

each directory has a README file that lists the maintainer of that addon.

## Repository

use make-repo.sh to build all addons and build a repository structure that ready to be deployed, with addons.xml and addons.xml.md5 files in root.
Note: for actual deployment you also need to generate the repository addon zip file, template is in repository.mytestrepository directory.

## Notes

This is intentionally not a forked openelec repo!
