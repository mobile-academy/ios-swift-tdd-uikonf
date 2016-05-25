//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation

class DefaultChatMessagesSender: ChatMessagesSender {

    var store: KCSAppdataStore
    
    init() {
        let collection = KCSCollection(fromString: "Messages", ofClass: NSDictionary.self)
        store = KCSAppdataStore(collection: collection, options: nil)
    }
    
    func send(message: String, completion: (ErrorType?) -> Void) {
        let newMessage = ["text" : message]
        store.saveObject(newMessage, withCompletionBlock: { result, error in
            completion(error)
        }, withProgressBlock: nil)
    }

}
