SwiftLog
========

Simple and easy logging in Swift.

## Features

- Super simple. Only one method to log.
- Rolled logs.
- Simple concise codebase at just at barely two hundred LOC.

## Example

SwiftLog can be used right out of the box with no configuration, simply call the logging function.

```swift
logw("write to the log!")
```

That will create a log file in the proper directory on both OS X and iOS. 

OS X log files will be created in the OS X log directory (found under: /Library/Logs). The iOS log files will be created in your apps document directory under a folder called Logs.

## Configuration

There are a few configurable options in SwiftLog.

```swift
//This writes to the log
logw("write to the log!")

//Set the name of the log files
Log.logger.name = "test" //default is "logwile"

//Set the max size of each log file. Value is in KB
Log.logger.maxFileSize = 2048 //default is 1024

//Set the max number of logs files that will be kept
Log.logger.name = 8 //default is 4

//Set the directory in which the logs files will be written
Log.logger.directory = "/Library/somefolder" //default is the standard logging directory for each platform.

```

## Installation

### Cocoapods

```
Coming soon...(Hopefully!)
```

### Carthage

Check out the [Carthage](https://github.com/Carthage/Carthage) docs on how to add a install. The `SwiftLog` framework is already setup with shared schemes.

[Carthage Install](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)

### Rogue

First see the [installation docs](https://github.com/acmacalister/Rogue) for how to install Rogue.

To install SwiftLog run the command below in the directory you created the rogue file.

```
rogue add https://github.com/daltoniam/SwiftLog
```

Next open the `libs` folder and add the `SwiftLog.xcodeproj` to your Xcode project. Once that is complete, in your "Build Phases" add the `SwiftLog.framework` to your "Link Binary with Libraries" phase. Make sure to add the `libs` folder to your `.gitignore` file.

### Other

Simply grab the framework (either via git submodule or another package manager).

Add the `SwiftLog.xcodeproj` to your Xcode project. Once that is complete, in your "Build Phases" add the `SwiftLog.framework` to your "Link Binary with Libraries" phase.

## TODOs

- [ ] Complete Docs
- [ ] Add Unit Tests

## License

SwiftLog is licensed under the MIT License.

## Contact

### Dalton Cherry
* https://github.com/daltoniam
* http://twitter.com/daltoniam
* http://daltoniam.com