import Foundation
import Quick
import Nimble

@testable import UIKonf


class AppDelegateSpec: QuickSpec {
    override func spec() {
        describe("AppDelegate") {

            var sut: AppDelegate?

            beforeEach {
                sut = AppDelegate()
            }

            it("should have kinvey client") {
                expect(sut?.kinveyClient).toNot(beNil())
            }

            describe("application did finish launching") {

                var fakeKinveyClient: FakeKinveyClient?

                beforeEach {
                    fakeKinveyClient = FakeKinveyClient()
                    sut?.kinveyClient = fakeKinveyClient!

                    sut?.application(UIApplication.sharedApplication(), didFinishLaunchingWithOptions: nil)
                }

                it("should tell its kinvey client to initialize") {
                    expect(fakeKinveyClient?.initializeCalled).to(beTruthy())
                }

                it("should tell kinvey client to register user") {
                    expect(fakeKinveyClient?.registerUserCalled).to(beTruthy())
                }

                describe("window") {

                    var window: UIWindow?

                    beforeEach {
                        window = sut?.window
                    }

                    it("should be a window") {
                        expect(window).toNot(beNil())
                    }

                    describe("root view controller") {

                        var rootViewController: RootViewController?

                        beforeEach {
                            rootViewController = window?.rootViewController as? RootViewController
                        }

                        it("should be a root view controller") {
                            expect(rootViewController).toNot(beNil())
                        }
                    }
                }
            }
        }
    }
}
