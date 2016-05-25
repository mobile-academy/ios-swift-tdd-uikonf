import Foundation
import Quick
import Nimble

@testable import UIKonf

class FakeChatMessagesProvider: ChatMessagesProvider {

    var updateMessagesCalled = false
    var lastInsertedMessage: ChatMessage?

    weak var delegate: ChatMessagesProviderDelegate?

    var chatMessages: [ChatMessage] = {
        let chatMessage1 = ChatMessage(text: "Fixture Text 1")
        let chatMessage2 = ChatMessage(text: "Fixture Text 2")
        return [chatMessage1, chatMessage2]
    }()

    func updateMessages() {
        updateMessagesCalled = true
    }

    func insertNewMessage(message: ChatMessage) {
        lastInsertedMessage = message
        chatMessages.append(message)
    }
}

class FakeChatMessagePresenter: ChatMessagePresenter {

    var lastPresentedTableViewCell: UITableViewCell?
    var lastPresentedChatMessage: ChatMessage?

    func presentChatMessage(chatMessage: ChatMessage, inTableViewCell tableViewCell: UITableViewCell) {
        lastPresentedChatMessage = chatMessage
        lastPresentedTableViewCell = tableViewCell
    }
}

class FakeChatMessagesSender: ChatMessagesSender {

    var lastMessage: String?
    var lastCompletion: ((ChatMessage?, ErrorType?) -> Void)?

    func send(message: String, completion: (ChatMessage?, ErrorType?) -> Void) {
        lastMessage = message
        lastCompletion = completion
    }

    func simulateSendingSuccess(chatMessage: ChatMessage) {
        lastCompletion?(chatMessage, nil)
    }

    func simulateSendingFailure(error: ErrorType) {
        lastCompletion?(nil, error)
    }
}

class ChatViewControllerSpec: QuickSpec {
    override func spec() {
        describe("ChatViewController") {

            var sut: ChatViewController?
            var fakeChatMessagesProvider: FakeChatMessagesProvider?
            var fakeChatMessagePresenter: FakeChatMessagePresenter?
            var fakeChatMessageSender: FakeChatMessagesSender!

            beforeEach {
                fakeChatMessagesProvider = FakeChatMessagesProvider()
                fakeChatMessagePresenter = FakeChatMessagePresenter()
                fakeChatMessageSender = FakeChatMessagesSender()

                sut = ChatViewController(chatMessagesProvider: fakeChatMessagesProvider!, chatMessagePresenter: fakeChatMessagePresenter!, chatMessageSender: fakeChatMessageSender)
            }

            it("should have a title") {
                expect(sut?.title).to(equal("UIKonf Chat"))
            }

            it("should set itself as delegate of its messages provider") {
                expect(fakeChatMessagesProvider?.delegate) === sut
            }

            describe("view will appear") {

                beforeEach {
                    sut?.viewWillAppear(true)
                }

                it("should tell is messages provider to update messages") {
                    expect(fakeChatMessagesProvider?.updateMessagesCalled).to(beTruthy())
                }
            }

            describe("pressing send button") {
                beforeEach {
                    sut?.view

                    sut?.textView.text = "test-message"
                    sut?.didPressRightButton(nil)
                }

                it("should send entered text") {
                    expect(fakeChatMessageSender.lastMessage).to(equal("test-message"))
                }

                context("when successful") {
                    var chatMessage: ChatMessage!
                    beforeEach {
                        fakeChatMessagesProvider!.chatMessages = []

                        chatMessage = ChatMessage(text: "Fixture Chat Message 1")
                        fakeChatMessageSender.simulateSendingSuccess(chatMessage)
                    }

                    it("should pass new message to provider") {
                        expect(fakeChatMessagesProvider!.lastInsertedMessage).to(equal(chatMessage))
                    }

                    it("should reload table view") {
                        expect(sut!.tableView!.numberOfRowsInSection(0)).to(equal(1))
                    }
                }

                context("when failed") {
                    beforeEach {
                        let error = NSError(domain: "fixture.com", code: 1, userInfo: nil)
                        fakeChatMessageSender.simulateSendingFailure(error)
                    }

                    it("should not update messages") {
                        expect(fakeChatMessagesProvider!.updateMessagesCalled).to(beFalsy())
                    }
                }
            }

            describe("number of rows in section") {

                var numberOfItems: Int?

                beforeEach {
                    numberOfItems = sut?.tableView((sut?.tableView)!, numberOfRowsInSection: 0)
                }
                
                it("should return number of chat messages") {
                    expect(numberOfItems).to(equal(2))
                }
            }

            describe("cell for row at index path") {

                var tableViewCell: UITableViewCell?

                beforeEach {
                    sut?.view
                    tableViewCell = sut?.tableView((sut?.tableView)!, cellForRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
                }

                it("should return a table view cell") {
                    expect(tableViewCell).toNot(beNil())
                }

                it("should tell its presenter to present data for given chat message in dequeued cell") {
                    expect(fakeChatMessagePresenter?.lastPresentedTableViewCell) === tableViewCell
                }

                it("should pass the appropriate data to chat presenter") {
                    expect(fakeChatMessagePresenter?.lastPresentedChatMessage?.text).to(equal("Fixture Text 1"))
                }
            }

            describe("chat messages provider delegate") {

                describe("did finish loading data") {

                    beforeEach {
                        sut?.view

                        fakeChatMessagesProvider?.chatMessages = [
                            ChatMessage(text: "Fixture Chat Message 1")
                        ]
                        sut?.chatMessagesProviderDidFinishLoading(fakeChatMessagesProvider!)
                    }

                    it("should state that it has one item in its table view") {
                        expect(sut?.tableView?.numberOfRowsInSection(0)).to(equal(1))
                    }
                }
            }
        }
    }
}
