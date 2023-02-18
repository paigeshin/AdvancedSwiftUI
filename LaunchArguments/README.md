#  Launch Arguments

```swift
let userIsSignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn") ? true : false
let value = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"] == "true" ? true : false
```
