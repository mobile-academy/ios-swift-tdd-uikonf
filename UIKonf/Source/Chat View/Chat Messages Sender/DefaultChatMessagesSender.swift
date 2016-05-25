//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation

class DefaultChatMessagesSender: ChatMessagesSender {

    var store: KCSAppdataStore
    var parser: ChatMessagesParser

    init() {
        let collection = KCSCollection(fromString: "Messages", ofClass: NSDictionary.self)
        store = KCSAppdataStore(collection: collection, options: nil)
        parser = ChatMessagesParser()
    }
    
    func send(message: String, completion: (ChatMessage?, ErrorType?) -> Void) {
        let newMessage = ["text" : message]
        store.saveObject(newMessage, withCompletionBlock: { [weak self] results, error in
            guard let _self = self else { return }

            var messages: [ChatMessage]?
            if let results = results {
                messages = _self.parser.parseChatMessages(results)
            }

            completion(messages?.first, error)
        }, withProgressBlock: nil)
    }

}
