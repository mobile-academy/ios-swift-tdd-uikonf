import Foundation
@testable import UIKonf

class FakeChatMessagesParser: ChatMessagesParser {

    var returnedChatMessages: [ChatMessage] = []
    var expectedChatMessagesToParse: [[String:String]] = []

    override func parseChatMessages(chatMessages: [AnyObject]) -> [ChatMessage] {
        guard let chatMessages = chatMessages as? [[String:String]] else {
            return []
        }

        if (expectedChatMessagesToParse == chatMessages) {
            return returnedChatMessages
        }

        return []
    }
}
