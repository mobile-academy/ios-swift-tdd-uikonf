import Foundation
import Quick
import Nimble

@testable import UIKonf


class DefaultChatMessagePresenterSpec: QuickSpec {
    override func spec() {
        describe("DefaultChatMessagePresenter") {

            var sut: DefaultChatMessagePresenter?

            beforeEach {
                sut = DefaultChatMessagePresenter()
            }

            describe("present chat message") {

                var tableViewCell: UITableViewCell?

                beforeEach {
                    let chatMessage = ChatMessage(text: "Fixture Text")
                    let nib = UINib(nibName: "ChatTableViewCell", bundle: nil)

                    tableViewCell = nib.instantiateWithOwner(nil, options: nil).first as? UITableViewCell

                    sut?.presentChatMessage(chatMessage, inTableViewCell: tableViewCell!)
                }

                it("should set the chat message as text label text") {
                    expect(tableViewCell?.textLabel?.text).to(equal("Fixture Text"))
                }
            }
        }
    }
}
