import Foundation

@testable import UIKonf

class FakeChatMessagesUpdater: ChatMessagesUpdater {

    private var lastCompletion: ((result: [ChatMessage]?, error: NSError?) -> (Void))?

    func simulateSuccessWithResult(result: [ChatMessage]) {
        if let completion = lastCompletion {
            completion(result: result, error: nil)
        }
    }

    func simulateFailureWithError(error: NSError) {
        if let completion = lastCompletion {
            completion(result: nil, error: error)
        }
    }

    override func updateChatMessages(completion: (result:[ChatMessage]?, error:NSError?) -> (Void)) {
        lastCompletion = completion
    }
}
