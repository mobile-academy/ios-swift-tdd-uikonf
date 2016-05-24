//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation

class DefaultChatMessagesProvider: ChatMessagesProvider {

    weak var delegate: ChatMessagesProviderDelegate?

    var chatMessages: [ChatMessage] = []

    var chatMessagesUpdater = ChatMessagesUpdater()

    func updateMessages() {

        self.delegate?.chatMessagesProviderWillBeginLoading(self)

        chatMessagesUpdater.updateChatMessages {
            (result, error) -> (Void) in

            if let unwrappedChatMessages = result {
                self.chatMessages = unwrappedChatMessages
                self.delegate?.chatMessagesProviderDidFinishLoading(self)
            }
            if let unwrappedError = error {
                self.delegate?.chatMessagesProviderDid(self, didFailWithError: unwrappedError)
            }
        }
    }

    func insertNewMessage(message: ChatMessage) {
        chatMessages.append(message)
    }
}
