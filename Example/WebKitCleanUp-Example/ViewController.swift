//
//  ViewController.swift
//  WebKitCleanUp-Example
//
//  Created by Hoang Nguyen on 8/8/23.
//

import UIKit
import WebKitCleanUp

final class ViewController: UIViewController {
    
    private let webKitCleanUp: WebKitCleanUp
    
    init(webKitCleanUp: WebKitCleanUp) {
        self.webKitCleanUp = webKitCleanUp
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        startWebKitCleanUp()
    }
    
    func startWebKitCleanUp() {
        if #available(iOS 13.0, *) {
            let backgroundScheduler = WebKitCleanUpBackgroundScheduler(webKitCleanUp: webKitCleanUp)
            backgroundScheduler.submitWebKitCleanUp(taskIdentifier: "")
        } else {
            let foregroundScheduler = WebKitCleanUpForegroundScheduler(webKitCleanUp: webKitCleanUp)
            foregroundScheduler.executeWebKitCleanUp(cacheTypes: [.disk])
        }
    }
}

