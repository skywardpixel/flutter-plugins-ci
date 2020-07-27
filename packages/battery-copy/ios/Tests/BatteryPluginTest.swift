//
//  BatteryPluginTest.swift
//  battery_pluginTests
//
//  Created by Kyle Yan on 7/27/20.
//

@testable import battery
import XCTest

class BatteryPluginTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("Hey this is a test")
        let plugin = SwiftBatteryPlugin()
        let methodCall = FlutterMethodCall(methodName: "getBatteryLevel", arguments: [])
        plugin.handle(methodCall, result: { (result) in
            if let batteryLevel = result as? Int {
                print("Battery level is \(batteryLevel)")
            } else if (result is FlutterError?) {
                // expected to print this in simulator
                // not mocking for simplicity
                print("Unable to read battery level")
            }
        })
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
