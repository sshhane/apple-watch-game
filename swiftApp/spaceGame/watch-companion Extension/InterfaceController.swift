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
    @IBOutlet weak var roll: WKInterfaceLabel!
    
    // vars
    var rollStr = ""
    
    // motion manager
    let motionManager = CMMotionManager()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        reloadData(move: "left")
        
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
//            print(data as Any)
            if let d = data {
                let r = d.attitude.roll
                self.rollStr = "Roll:  \(Double(r))"
            }
            self.updateLabel()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateLabel()
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
        self.rollStr = "left"
        updateLabel()
    }
    
    @IBAction func moveRight() {
        reloadData(move: "right")
        self.rollStr = "right"
        updateLabel()
    }
    
    private func sendMove(move: String) {
        if WCSession.isSupported() {
            let  session = WCSession.default
            session.delegate = self as! WCSessionDelegate
            session.activate()
        }
    }
    
    func updateLabel() {
        roll.setText(rollStr)
    }
    
    func startDeviceMotionUpdates() {
        
    }
    
//    var attitude: CMAttitude { get }
    
//    let motionManager = CMMotionManager()
//    motionManager.deviceMotionUpdateInterval = 1.0 / 50
}
