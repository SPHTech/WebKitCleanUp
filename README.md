# WebKitCleanUp Version 0.0.1

### How to used:
#### Step 1: Register background task on AppDelegate
```
 lazy var cleanUp: WebKitCleanUp = {
    let config = WebKitCleanUpConfig(cleanUpEnabled: true, cleanUpDuration: 60)
    return WebKitCleanUpImp(webKitCleanUpConfig: config)
}()
````
```
func registerWebKitCleanUpOnBackgroundTask(taskIdentifier: String, types: [WebKitCacheType]) {
    guard #available(iOS 13.0, *) else { return }
    let bgScheduler = WebKitCleanUpBackgroundScheduler(webKitCleanUp: cleanUp)
    bgScheduler.registerBackgroundTask(taskIdentifier: taskIdentifier, cacheTypes: types)
}
```

```
func application(_ application: UIApplication,
                didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.registerWebKitCleanUpOnBackgroundTask(taskIdentifier: "", types: [.disk]) /// Please update taskIdentifier and types
    return true
}
```

#### Step 2. Executed webkit clean up in place we want to clean up
```
func startWebKitCleanUp() {
    if #available(iOS 13.0, *) {
        let bgScheduler = WebKitCleanUpBackgroundScheduler(webKitCleanUp: cleanUp)
        bgScheduler.submitWebKitCleanUp(taskIdentifier: "") /// Please update taskIdentifier
    } else {
        let fgScheduler = WebKitCleanUpForegroundScheduler(webKitCleanUp: cleanUp)
        fgScheduler.executeWebKitCleanUp(cacheTypes: [.disk]) /// Please update taskIdentifier
    }
}
```

### Technical use:
- Swift
- WebKit
- BackgroundTasks
- Component architecture
