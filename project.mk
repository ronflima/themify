# -*-makefile-*-
# MIT License
#
# Copyright (c) 2017 Ronaldo F. Lima
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Sample Project File
# (C) 2017 - Ronaldo Faria Lima
#

# This was created with git submodules in mind. So, MODULES variable contains a
# list of names of modules used by your project. Your modules must be placed on
# Modules directory. If you want to place your modules someplace else, you can
# override here the DEPS variable. See main Makefile to see how it is
# created. But edit it here.
MODULES=

# This is the xcodeproj bundle for your project. 
PROJECT=Themify.xcodeproj

# This is the scheme you want to build from command line
SCHEME="Themify"

# This is the target you want to build from command line
TARGET=Themify

#
# Overrides
#

# Uncomment below if you want to build on Debug mode. By default, the main
# makefile builds using Release configuration.

# CONFIGURATION=Debug

# Uncomment and edit below if you want to have your submodules placed on a
# directory different from Modules. Replace the Modules/% to MyPlace/% to setup
# the correct directory.

# DEPS=${MODULES:%=Modules/%}

#
# Uncomment and edit below to customize where your derived data will
# reside. CAREFUL: the clean-all target will recursively delete this directory.
#

# BUILDDIR=build

#
# Uncomment and edit below to customize Xcode's destination settings. By
# default, it uses the generic setting for iOS compilation.
#

# DESTINATION="generic/platform=iOS"
