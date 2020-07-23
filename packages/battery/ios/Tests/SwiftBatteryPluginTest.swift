import XCTest

public class SwiftBatteryPluginTest {
    let r = SwiftBatteryPlugin()

    func testIsPhysicalDevice() {
        XCTAssertEqual(r.isDevicePhysical(), "false")
    }

    func testSuccessCall(){
        let mCall = FlutterMethodCall.init(methodName: "getBatteryLevel", arguments: nil)

        r.handle(mCall)  { (result) -> () in
            var jsonResult = result as! Dictionary<String, AnyObject>
            print(jsonResult)
            XCTAssertNotNil(jsonResult["utsname"])
        }
    }
}
