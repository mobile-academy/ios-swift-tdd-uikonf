import Foundation

@testable import UIKonf

class FakeKCSAppdataStore: KCSAppdataStore {

    var lastSavedObject: AnyObject?
    var lastQuery: AnyObject?

    private var lastCompletionBlock: KCSCompletionBlock?
    private var lastProgressBlock: KCSProgressBlock?

    func simulateQuerySuccessWithResponse(response: [AnyObject]) {
        if let completionBlock = lastCompletionBlock {
            completionBlock(response, nil)
        }
    }

    func simulateQueryFailureWithError(error: NSError) {
        if let completionBlock = lastCompletionBlock {
            completionBlock(nil, error)
        }
    }
    
    override func queryWithQuery(query: AnyObject!, withCompletionBlock completionBlock: KCSCompletionBlock!, withProgressBlock progressBlock: KCSProgressBlock!) -> KCSRequest! {
        lastQuery = query
        lastCompletionBlock = completionBlock
        lastProgressBlock = progressBlock
        
        return nil
    }
    
    override func saveObject(object: AnyObject!, withCompletionBlock completionBlock: KCSCompletionBlock!, withProgressBlock progressBlock: KCSProgressBlock!) -> KCSRequest! {
        lastSavedObject = object
        lastCompletionBlock = completionBlock
        lastProgressBlock = progressBlock
        
        return nil
    }

}
