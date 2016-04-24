import Foundation
import Quick
import Nimble

@testable import UIKonf


class RootViewControllerSpec: QuickSpec {
    override func spec() {
        describe("RootViewController") {

            var sut: RootViewController?

            beforeEach {
                sut = RootViewController()
            }

            describe("when the view loads") {

                var view: UIView?

                beforeEach {
                    view = sut?.view
                }

                describe("contained navigation controller") {

                    var containedNavigationController: UINavigationController?

                    beforeEach {
                        containedNavigationController = sut?.containedNavigationController
                    }

                    it("should add the navigation controllers view") {
                        expect(view?.subviews).to(contain(containedNavigationController?.view))
                    }

                    describe("top view controller") {

                        var chatViewController: ChatViewController?

                        beforeEach {
                            chatViewController = containedNavigationController?.topViewController as? ChatViewController
                        }

                        it("should be a chat view controller") {
                            expect(chatViewController).toNot(beNil())
                        }

                        describe("chat messages provider") {

                            var chatMessagesProvider: DefaultChatMessagesProvider?

                            beforeEach {
                                chatMessagesProvider = chatViewController?.chatMessagesProvider as? DefaultChatMessagesProvider
                            }

                            it("should be a default chat messages provider") {
                                expect(chatMessagesProvider).toNot(beNil())
                            }
                        }

                        describe("chat message presenter") {

                            var chatMessagePresenter: DefaultChatMessagePresenter?

                            beforeEach {
                                chatMessagePresenter = chatViewController?.chatMessagePresenter as? DefaultChatMessagePresenter
                            }

                            it("should be a default chat message presenter") {
                                expect(chatMessagePresenter).toNot(beNil())
                            }
                        }
                    }
                }
            }
        }
    }
}
