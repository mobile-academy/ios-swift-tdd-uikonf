import Foundation
import Quick
import Nimble

@testable import UIKonf

extension ChatMessage: Equatable {
}

func ==(lhs: ChatMessage, rhs: ChatMessage) -> Bool {
    let areEqual = lhs.text == rhs.text
    return areEqual
}

class ChatMessagesUpdaterSpec: QuickSpec {
    override func spec() {
        describe("ChatMessagesUpdater") {

            var sut: ChatMessagesUpdater?

            beforeEach {
                sut = ChatMessagesUpdater()
            }

            describe("update chat messages") {

                var fakeStore: FakeKCSAppdataStore?

                var capturedResult: [ChatMessage]?
                var capturedError: NSError?

                beforeEach {
                    fakeStore = FakeKCSAppdataStore()

                    sut?.store = fakeStore!

                    sut?.updateChatMessages({
                        result, error in

                        capturedResult = result
                        capturedError = error
                    })
                }

                afterEach {
                    capturedError = nil
                    capturedResult = nil
                }

                it("should make a request") {
                    expect(fakeStore?.lastQuery as? KCSQuery).toNot(beNil())
                }

                describe("when the request is successful") {

                    var chatMessage1: ChatMessage!
                    var chatMessage2: ChatMessage!

                    beforeEach {
                        let fakeChatMessagesParser = FakeChatMessagesParser()

                        chatMessage1 = ChatMessage(text: "Fixture Text 1")
                        chatMessage2 = ChatMessage(text: "Fixture Text 2")

                        fakeChatMessagesParser.returnedChatMessages = [chatMessage1, chatMessage2]

                        fakeChatMessagesParser.expectedChatMessagesToParse = [["text": "Fixture Text 1"],
                                                                              ["text": "Fixture Text 2"]]
                        sut?.chatMessagesParser = fakeChatMessagesParser

                        fakeStore?.simulateQuerySuccessWithResponse([["text": "Fixture Text 1"],
                                                                     ["text": "Fixture Text 2"]])
                    }

                    it("should return the chat messages from its parser") {
                        expect(capturedResult).to(equal([chatMessage1, chatMessage2]))
                    }

                    it("should return no error") {
                        expect(capturedError).to(beNil())
                    }
                }

                describe("when the request fails") {

                    var error: NSError?

                    beforeEach {
                        error = NSError(domain: "fixture.com", code: 42, userInfo: nil)

                        fakeStore?.simulateQueryFailureWithError(error!)
                    }

                    it("should call the completion block with error") {
                        expect(capturedError).to(equal(error))
                    }

                    it("should have no response") {
                        expect(capturedResult).to(beNil())
                    }
                }
            }
        }
    }
}
