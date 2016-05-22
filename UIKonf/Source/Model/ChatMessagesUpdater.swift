//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation

class ChatMessagesUpdater {

    var store: KCSAppdataStore

    var chatMessagesParser: ChatMessagesParser

    init() {
        let collection = KCSCollection(fromString: "Messages", ofClass: NSDictionary.self)
        store = KCSAppdataStore(collection: collection, options: nil)
        chatMessagesParser = ChatMessagesParser()
    }

    func updateChatMessages(completion: (result:[ChatMessage]?, error:NSError?) -> (Void)) {
        
        let query = KCSQuery()

        store.queryWithQuery(query, withCompletionBlock: {
            result, error in

            var parsedMessages: [ChatMessage]?

            if let unwrappedResult = result {
                parsedMessages = self.chatMessagesParser.parseChatMessages(unwrappedResult)
            }

            completion(result: parsedMessages, error: error)
        }, withProgressBlock: nil)
    }
}
