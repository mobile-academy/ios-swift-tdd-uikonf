import Foundation
import Quick
import Nimble

@testable import UIKonf

class FakeChatMessagesProviderDelegate: ChatMessagesProviderDelegate {

    var providerFromWillBeginLoading: ChatMessagesProvider?
    var providerFromDidFinishLoading: ChatMessagesProvider?
    var providerFromDidFailWithError: ChatMessagesProvider?

    func chatMessagesProviderWillBeginLoading(provider: ChatMessagesProvider) {
        providerFromWillBeginLoading = provider
    }

    func chatMessagesProviderDidFinishLoading(provider: ChatMessagesProvider) {
        providerFromDidFinishLoading = provider
    }

    func chatMessagesProviderDid(provider: ChatMessagesProvider, didFailWithError error: NSError) {
        providerFromDidFailWithError = provider
    }
}

class DefaultChatMessagesProviderSpec: QuickSpec {
    override func spec() {
        describe("DefaultChatMessagesProvider") {

            var fakeDelegate: FakeChatMessagesProviderDelegate?
            var sut: DefaultChatMessagesProvider?

            beforeEach {
                fakeDelegate = FakeChatMessagesProviderDelegate()

                sut = DefaultChatMessagesProvider()
                sut?.delegate = fakeDelegate
            }

            describe("update chat messages") {

                var fakeMessagesUpdater: FakeChatMessagesUpdater?

                beforeEach {
                    fakeMessagesUpdater = FakeChatMessagesUpdater()
                    sut?.chatMessagesUpdater = fakeMessagesUpdater!

                    sut?.updateMessages()
                }

                it("should inform its delegate that it will start loading") {
                    expect(fakeDelegate?.providerFromWillBeginLoading as? DefaultChatMessagesProvider) === sut
                }

                describe("when updating is successful") {

                    var chatMessage1: ChatMessage?
                    var chatMessage2: ChatMessage?

                    beforeEach {
                        chatMessage1 = ChatMessage(text: "Fixture Text 1")
                        chatMessage2 = ChatMessage(text: "Fixture Text 2")

                        fakeMessagesUpdater?.simulateSuccessWithResult([chatMessage1!, chatMessage2!])
                    }

                    it("should tell its delegate that it finished updating") {
                        expect(fakeDelegate?.providerFromDidFinishLoading as? DefaultChatMessagesProvider) === sut
                    }

                    it("should save the chat messages") {
                        expect(sut?.chatMessages).to(equal([chatMessage1!, chatMessage2!]))
                    }
                }

                describe("when updating fails") {

                    var error: NSError?

                    beforeEach {
                        error = NSError(domain: "fixture.com", code: 42, userInfo: nil)

                        fakeMessagesUpdater?.simulateFailureWithError(error!)
                    }

                    it("should inform its delegate that it failed") {
                        expect(fakeDelegate?.providerFromDidFailWithError as? DefaultChatMessagesProvider) === sut
                    }
                }
            }
        }
    }
}
