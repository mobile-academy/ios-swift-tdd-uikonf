//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation

class ChatMessagesUpdater {

    var store: KCSAppdataStore

    init() {
        let collection = KCSCollection(fromString: "Messages", ofClass: NSDictionary.self)
        store = KCSAppdataStore(collection: collection, options: nil)
    }

    func updateChatMessages(completion: (result:[ChatMessage]?, error:NSError?) -> (Void)) {
        
        let query = KCSQuery()

        store.queryWithQuery(query, withCompletionBlock: {
            result, error in

            var parsedMessages: [ChatMessage]?

            //TODO: Parse messages

            completion(result: parsedMessages, error: error)
        }, withProgressBlock: nil)
    }
}
