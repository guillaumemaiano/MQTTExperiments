//
//  ViewController.swift
//  ProjectSpacebase
//
//  Created by guillaume MAIANO on 18/03/2019.
//  Copyright © 2019 guillaume MAIANO. All rights reserved.
//

import UIKit
import CocoaMQTT

// very unfancy "learning project" following https://medium.com/thefloatingpoint/mqtt-in-ios-d8574b55e006
class ViewController: UIViewController {

    @IBOutlet weak var mqttLabel: UILabel!

    // improvement: instead of optional, build it as a lazy var, and connect at the end of the didLoad
    var mqtt: CocoaMQTT?
    // improvement: pull the server URL from a secret
    let mqttHostStr = "localhost"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMQTT()
    }

    // maybe have a setupMQTT method that returns the setup client, and another that uses it to connect?
    func setupMQTT() {
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        // port 1883 is standard as per https://mqtt.org/faq
        let standardPort: UInt16 = 1883
        mqtt = CocoaMQTT(clientID: clientID, host: mqttHostStr, port: standardPort)
        // authentication added in v3.1
        mqtt?.username = "test"
        mqtt?.password = "public"
        // for this learning project, the view controller is its own delegate (as per an extension file)
        mqtt?.delegate = self
        // last will cannot be changed later: https://stackoverflow.com/questions/49163609/change-will-on-a-mqtt-connection
        // further explained: https://www.hivemq.com/blog/mqtt-essentials-part-9-last-will-and-testament/
        mqtt?.willMessage = CocoaMQTTWill( topic: "/will", message: "dieout")
        mqtt?.keepAlive = 60
        mqtt?.connect()
    }
}
