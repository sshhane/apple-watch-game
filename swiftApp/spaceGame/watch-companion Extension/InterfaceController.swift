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
import CoreMotion

class InterfaceController: WKInterfaceController {
    
    // label
    @IBOutlet weak var pitch: WKInterfaceLabel!
    
    // vars
    var value = 0.0
    var rollStr = ""
    
    // motion manager
    let motionManager = CMMotionManager()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        // record every half second
        motionManager.deviceMotionUpdateInterval = 0.2
        // begin motion capture
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
            self.value = ((data?.attitude.pitch)!)
            print("value is: \(self.value)")
            self.reloadData()
//            self.pitch.setText("Pitch:  \(self.value)")
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func reloadData() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.sendMessage(["pitch":self.value], replyHandler: { response in
                print("received from iphone: \(response)")
            }, errorHandler: { error in
                print("error: \(error)")
            })
        }
    }
    
    private func sendRoll(roll: String) {
        if WCSession.isSupported() {
            let  session = WCSession.default
            session.delegate = self as! WCSessionDelegate
            session.activate()
        }
    }
}
