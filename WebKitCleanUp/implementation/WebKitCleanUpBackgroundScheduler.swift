//
//  WebKitCleanUpBackgroundScheduler.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation
import WebKit
#if canImport(BackgroundTasks)
import BackgroundTasks
#endif

// MARK: WebKitCleanUpBackgroundScheduler
@available(iOS 13.0, *)
public struct WebKitCleanUpBackgroundScheduler {
    
    private enum Constants {
        static let dispatchQueueLabel = "com.sph.background.web_kit_clean_up_queue"
    }
    
    private let webKitCleanUp: WebKitCleanUp
    private let dispatchQueue: DispatchQueueType
    
    public init(webKitCleanUp: WebKitCleanUp,
                dispatchQueue: DispatchQueueType) {
        self.webKitCleanUp = webKitCleanUp
        self.dispatchQueue = dispatchQueue
    }
    
    public init(webKitCleanUp: WebKitCleanUp) {
        self.init(webKitCleanUp: webKitCleanUp,
                  dispatchQueue: DispatchQueue(label: Constants.dispatchQueueLabel, attributes: .concurrent))
    }
    
    public func submitWebKitCleanUp(taskIdentifier: String) {
        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: taskIdentifier)
        let request = BGProcessingTaskRequest(identifier: taskIdentifier)
        request.requiresNetworkConnectivity = false
        request.requiresExternalPower = true
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            // TODO: Trigger Analystic event when clean up failed
        }
    }
    
    public func registerBackgroundTask(taskIdentifier: String, cacheTypes: [WebKitCacheType]) {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: taskIdentifier, using: nil) { task in
            guard let processingTask = task as? BGProcessingTask else {
                task.setTaskCompleted(success: false)
                return
            }
            self.executeWebKitCleanUp(task: processingTask, cacheTypes: cacheTypes)
        }
    }
    
    private func executeWebKitCleanUp(task: BGProcessingTask, cacheTypes: [WebKitCacheType]) {
        let workItem = DispatchWorkItem(block: {
            webKitCleanUp.webKitDidCleanUpCache(cacheTypes: cacheTypes,
                                                completionHandler: {
                #if DEBUG || QA
                triggerNotificationWith(title: "[Debug and QA only alert] Webkit Clean up",
                                        body: "Webkit clean up job finished on background mode")
                #endif
                task.setTaskCompleted(success: true)
                // TODO: Trigger Analystic event when clean up finish
            })
        })
        task.expirationHandler = { workItem.cancel() }
        dispatchQueue.async(work: { workItem.perform() })
    }
    
    private func triggerNotificationWith(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "com.sph.web_kit_clean_up.debug.notification", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { _ in }
    }
}
