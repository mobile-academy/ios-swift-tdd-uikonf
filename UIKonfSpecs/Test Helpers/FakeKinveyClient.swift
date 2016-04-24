//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
@testable import UIKonf

class FakeKinveyClient: KinveyClient {

    var initializeCalled = false
    var registerUserCalled = false

    override func initializeKinvey() {
        initializeCalled = true
    }

    override func registerUserIfNeeded() {
        registerUserCalled = true
    }
}
