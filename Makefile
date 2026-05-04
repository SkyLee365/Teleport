.PHONY: format lint build launch

XCODEBUILD ?= xcodebuild
PROJECT ?= Teleport.xcodeproj
SCHEME ?= Teleport
CONFIGURATION ?= Debug
DESTINATION ?= platform=macOS

TARGET_BUILD_DIR := $(shell $(XCODEBUILD) -project $(PROJECT) -scheme $(SCHEME) -configuration $(CONFIGURATION) -destination '$(DESTINATION)' -showBuildSettings | awk -F' = ' '/TARGET_BUILD_DIR/{print $$2; exit}')
APP_BUNDLE := $(TARGET_BUILD_DIR)/$(SCHEME).app

format:
	swift format -r -p -i .

lint:
	swift format lint -r -p .

build:
	$(XCODEBUILD) -project $(PROJECT) -scheme $(SCHEME) -configuration $(CONFIGURATION) -destination '$(DESTINATION)' build

launch: build
	pkill -x "$(SCHEME)" || true
	sleep 0.5
	open "$(APP_BUNDLE)"
