//
//  InterfaceController.swift
//  watch-companion Extension
//
//  Created by Shane Daniels on 03/04/2019.
//  Copyright © 2019 Shane Daniels. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        reloadData(move: "left")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func reloadData(move: String) {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.sendMessage(["request":move], replyHandler: { response in
                print("received from iphone: \(response)")
            }, errorHandler: { error in
                print("error: \(error)")
            })
        }
    }
    
    //
    @IBAction func moveLeft() {
        reloadData(move: "left")
    }
    
    @IBAction func moveRight() {
        reloadData(move: "right")
    }
    
    private func sendMove(move: String) {
        if WCSession.isSupported() {
            let  session = WCSession.default
            session.delegate = self as! WCSessionDelegate
            session.activate()
        }
        
        
    }
    
}
