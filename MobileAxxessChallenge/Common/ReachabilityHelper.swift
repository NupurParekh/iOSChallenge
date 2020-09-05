//
//  Reachability.swift
//  MobileAxxessChallenge
//
//  Created by Nupur Parekh on 03/09/20.
//  Copyright © 2020 Nupur Parekh. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityHelper {
    
    static let reachabilityInstance = ReachabilityHelper()
    private var reachability:Reachability!
    var isReachable=false
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: Notification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability = Reachability.init()
            try self.reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    //MARK:- Network change check
    @objc func reachabilityChanged(notification:Notification) {
        let reachability = notification.object as! Reachability
        if reachability.connection == .wifi {
            print("Reachable via WiFi")
            isReachable = true
        } else if reachability.connection == .cellular {
            print("Reachable via Cellular")
            isReachable = true
        } else {
            print("Network not reachable")
            isReachable = false
        }
    }
    
}

