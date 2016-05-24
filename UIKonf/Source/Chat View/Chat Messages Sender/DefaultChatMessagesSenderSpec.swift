import Foundation
import Quick
import Nimble

@testable import UIKonf

class DefaultChatMessagesSenderSpec: QuickSpec {
    override func spec() {
        var sut: DefaultChatMessagesSender!

       	beforeEach {
            sut = DefaultChatMessagesSender()
        }

        afterEach {
            sut = nil
        }

        describe("sending message") {
            var fakeStore: FakeKCSAppdataStore!

            var completionCalled = false
            var capturedError: ErrorType?

            beforeEach {
                fakeStore = FakeKCSAppdataStore()
                sut.store = fakeStore

                sut.send("Fixture message") { error in
                    completionCalled = true
                    capturedError = error
                }
            }

            it("should save message dictionary object") {
                expect(fakeStore.lastSavedObject?["text"]).to(equal("Fixture message"))
            }

            context("when operation was successful") {
                beforeEach {
                    fakeStore.simulateQuerySuccessWithResponse([])
                }

                it("should call completion without error") {
                    expect(completionCalled).to(beTruthy())
                    expect(capturedError).to(beNil())
                }
            }

            context("when opertion failed") {
                beforeEach {
                    let error = NSError(domain: "fixture.com", code: 1, userInfo: nil)
                    fakeStore.simulateQueryFailureWithError(error)
                }

                it("should call completion with an error") {
                    expect(completionCalled).to(beTruthy())
                    expect(capturedError).notTo(beNil())
                }
            }
        }
    }
}
