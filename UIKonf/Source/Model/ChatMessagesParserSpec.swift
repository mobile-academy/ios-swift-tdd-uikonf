import Foundation
import Quick
import Nimble

@testable import UIKonf


class ChatMessagesParserSpec: QuickSpec {
    override func spec() {
        describe("ChatMessagesParser") {

            var sut: ChatMessagesParser?

            beforeEach {
                sut = ChatMessagesParser()
            }

            describe("parse chat messages") {

                var chatMessages: [ChatMessage]?

                beforeEach {
                    chatMessages = sut?.parseChatMessages([["text" : "Fixture Text 1"], ["text" : "Fixture Text 2"], ["text" : "Fixture Text 3"]])
                }

                it("should have three chat messages") {
                    expect(chatMessages).to(haveCount(3))
                }

                describe("first chat message") {

                    var chatMessage: ChatMessage?

                    beforeEach {
                        chatMessage = chatMessages?[0]
                    }

                    it("should have appropriate text") {
                        expect(chatMessage?.text).to(equal("Fixture Text 1"))
                    }
                }

                describe("second chat message") {

                    var chatMessage: ChatMessage?

                    beforeEach {
                        chatMessage = chatMessages?[1]
                    }

                    it("should have appropriate text") {
                        expect(chatMessage?.text).to(equal("Fixture Text 2"))
                    }
                }

                describe("third chat message") {

                    var chatMessage: ChatMessage?

                    beforeEach {
                        chatMessage = chatMessages?[2]
                    }

                    it("should have appropriate text") {
                        expect(chatMessage?.text).to(equal("Fixture Text 3"))
                    }
                }
            }
        }
    }
}
