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

            beforeEach {
                fakeStore = FakeKCSAppdataStore()
                sut.store = fakeStore

                sut.send("Fixture message") { error in
                    
                }
            }

            pending("should save message object") {
                
            }
        }
    }
}
