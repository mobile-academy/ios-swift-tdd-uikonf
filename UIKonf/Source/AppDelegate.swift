//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.mainScreen().bounds)

    var kinveyClient = KinveyClient()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject:AnyObject]?) -> Bool {
        MobileAcademyStyleSheet.applyStyleSheet()

        kinveyClient.initializeKinvey()
        kinveyClient.registerUserIfNeeded()

        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()

        return true
    }
}

