//
//  ViewController+MQTTDelegate.swift
//  ProjectSpacebase
//
//  Created by guillaume MAIANO on 18/03/2019.
//  Copyright © 2019 guillaume MAIANO. All rights reserved.
//
import UIKit
import CocoaMQTT

extension ViewController: CocoaMQTTDelegate {

    // These two methods are all we care about for now
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        // we could keep track of the connection state of the MQTT object
        // but it's simpler to just do the subscribe here in this learning project
        // we subscribe to a topic signalling user presence
        // possible implementations: ESP8266 + IR sensors, or simply publishing a "I'm there" message to the topic.
        self.mqtt?.subscribe("presence")
    }

    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        // since the message can carry a payload, we could pass relevant data as well
        if let msgString = message.string {
            DispatchQueue.main.async {
                self.mqttLabel.text = msgString
            }
        }
    }

    // Other required methods for CocoaMQTTDelegate
    func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        // true -> trust the SSL connection
        completionHandler(true)
    }

    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
    }

    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
    }

    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
    }

    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
    }

    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
    }

    func mqttDidPing(_ mqtt: CocoaMQTT) {
    }

    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
    }

    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
    }

    func _console(_ info: String) {
    }

}
