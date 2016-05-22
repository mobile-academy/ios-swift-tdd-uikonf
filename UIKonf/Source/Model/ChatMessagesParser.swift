//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation

class ChatMessagesParser {

    func parseChatMessages(chatMessages: [AnyObject]) -> [ChatMessage] {

        var parsedChatMessages: [ChatMessage] = []

        for message in chatMessages {
            if let chatMessage = message as? Dictionary<String, AnyObject> {

                let text = chatMessage["text"] as? String

                let parsedChatMessage = ChatMessage(text: text)
                parsedChatMessages.append(parsedChatMessage)
            }
        }

        return parsedChatMessages
    }
}
