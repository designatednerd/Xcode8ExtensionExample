//
//  ViewController.swift
//  FlavorFlavour
//
//  Created by Ellen Shapiro (Work) on 9/6/16.
//  Copyright © 2016 Designated Nerd Software. All rights reserved.
//

import Cocoa
import FlavorKit

/// The main view controller for the host mac app
class ViewController: NSViewController {
    
    @IBOutlet private var lastModeLabel: NSTextField!
    
    private let notificationWrapper = CFNotificationCenterWrapper()
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notificationWrapper.registerForNotifications(withIdentifier: FlavorMode.UStoUK.rawValue)
        self.notificationWrapper.registerForNotifications(withIdentifier: FlavorMode.UKtoUS.rawValue)
        
        let notificationName = NSNotification.Name(rawValue: CFNotificationReceived)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handle(notification:)),
                                               name: notificationName,
                                               object: nil)
    }
    
    deinit {
        self.notificationWrapper.removeCFNotificationListener()
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Notification handling
    
    @objc private func handle(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let identifier = userInfo["identifier"] as? String,
            let mode = FlavorMode(rawValue: identifier) else {
                assertionFailure("Could not parse notification \(notification))")
                return 
        }
        
        self.lastModeLabel.stringValue = mode.emojified
    }
}
