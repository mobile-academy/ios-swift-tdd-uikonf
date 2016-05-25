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
            var fakeParser: FakeChatMessagesParser!

            var completionCalled = false
            var capturedMessage: ChatMessage?
            var capturedError: ErrorType?

            beforeEach {
                fakeStore = FakeKCSAppdataStore()
                sut.store = fakeStore
                fakeParser = FakeChatMessagesParser()
                sut.parser = fakeParser

                sut.send("Fixture message") { message, error in
                    completionCalled = true
                    capturedMessage = message
                    capturedError = error
                }
            }

            it("should save message dictionary object") {
                expect(fakeStore.lastSavedObject?["text"]).to(equal("Fixture message"))
            }

            context("when operation was successful") {
                var message: ChatMessage!

                beforeEach {
                    message = ChatMessage(text: "Fixture-Message")

                    let response = [["fixture-key":"fixture-value"]]
                    fakeParser.expectedChatMessagesToParse = response
                    fakeParser.returnedChatMessages = [ message ]
                    fakeStore.simulateQuerySuccessWithResponse(response)
                }

                it("should call completion without error") {
                    expect(completionCalled).to(beTruthy())
                    expect(capturedMessage).to(equal(message))
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
                    expect(capturedMessage).to(beNil())
                    expect(capturedError).notTo(beNil())
                }
            }
        }
    }
}
