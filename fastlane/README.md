fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## Android
### android prod
```
fastlane android prod
```
Deploy a new PROD version to the AppCenter
### android preprod
```
fastlane android preprod
```
Deploy a new PREPROD version to the AppCenter
### android dev
```
fastlane android dev
```
Deploy a new DEV version to the AppCenter
### android apks
```
fastlane android apks
```
Generate split apks for PlayStore Upload

----

## iOS
### ios prod
```
fastlane ios prod
```
Deploy a new PROD version to the AppCenter
### ios preprod
```
fastlane ios preprod
```
Deploy a new PREPROD version to the AppCenter
### ios dev
```
fastlane ios dev
```
Deploy a new DEV version to the AppCenter

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
