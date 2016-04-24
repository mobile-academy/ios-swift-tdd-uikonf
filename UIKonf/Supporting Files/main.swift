//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

func isRunningTests() -> Bool {
    let environment = NSProcessInfo.processInfo().environment
    if environment["XCTestConfigurationFilePath"] != nil {
        return true
    }
    return false
}


class UnitTestsAppDelegate: UIResponder, UIApplicationDelegate {

}

if isRunningTests() {
    UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(UnitTestsAppDelegate))
} else{
    UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(UIApplication), NSStringFromClass(AppDelegate))
}
