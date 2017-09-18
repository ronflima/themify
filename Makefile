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

# General Xcode project automation
# Author: Ronaldo Faria Lima <ronaldo@nineteen.com.br>

CONFIGURATION=Release
BUILDDIR=build
DESTINATION="generic/platform=iOS"
ARCHIVE_PATH=$(BUILDDIR)/archive
EXPORT_PATH=$(BUILDDIR)/export

include project.mk

DEPS=${MODULES:%=Modules/%}
BUILDSETTINGS=-derivedDataPath $(BUILDDIR) -jobs 8 -destination $(DESTINATION)

all: splash
	@echo "Building $(PROJECT)..."
	@xcodebuild $(BUILDSETTINGS) -scheme $(SCHEME) -configuration $(CONFIGURATION) -project $(PROJECT) build 
	@echo "Done."

archive: splash
	@echo "Archiving $(PROJECT)..."
	@$(eval BUILDSETTINGS="$(BUILDSETTINGS) -exportArchive -archivePath $(ARCHIVE_PATH) -exportPath $(EXPORT_PATH) -exportOptionsPList $(BUILDDIR)")
	@-mkdir $(ARCHIVE_PATH)
	@-mkdir $(EXPORT_PATH)
	@xcodebuild $(BUILDSETTINGS) -scheme $(SCHEME) -configuration $(CONFIGURATION) -project $(PROJECT) 2>&1 > build.log
	@echo "Done."

deps: splash
	@echo "Setting up dependencies..."
	@git submodule init $(DEPS)
	@git submodule update --recursive
	@echo "Done."

deps-deinit: splash
	@echo "Deinitializing dependencies..."
	@git submodule deinit --all
	@echo "Done."

build-list: splash
	@echo "Listing project options"
	@xcodebuild -list -project $(PROJECT)
	@echo "Done."

clean: splash
	@echo "Cleaning..."
	@xcodebuild $(BUILDSETTINGS) -scheme $(SCHEME) -configuration $(CONFIGURATION) -project $(PROJECT) clean 
	@echo "Done."

clean-all: clean
	@\rm -fR $(BUILDDIR)
	@echo "Derived and intermediate data purged. Done."

splash:
ifndef NOSPLASH
	@echo " _____ _                 _       ______       _ _     _ "
	@echo "/  ___(_)               | |      | ___ \     (_) |   | |"
	@echo "\ \`--. _ _ __ ___  _ __ | | ___  | |_/ /_   _ _| | __| |"
	@echo " \`--. \ | '_ \` _ \| '_ \| |/ _ \ | ___ \ | | | | |/ _\` |"
	@echo "/\__/ / | | | | | | |_) | |  __/ | |_/ / |_| | | | (_| |"
	@echo "\____/|_|_| |_| |_| .__/|_|\___| \____/ \__,_|_|_|\__,_|"
	@echo "                  | |"
	@echo "                  |_|\n"
	@echo "${PROJECT:%.xcodeproj=%} Automation"
	@echo "\n"
endif
