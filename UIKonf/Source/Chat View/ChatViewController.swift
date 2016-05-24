//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit
import SlackTextViewController

protocol ChatMessagesProviderDelegate: class {

    func chatMessagesProviderWillBeginLoading(provider: ChatMessagesProvider)

    func chatMessagesProviderDidFinishLoading(provider: ChatMessagesProvider)

    func chatMessagesProviderDid(provider: ChatMessagesProvider, didFailWithError error: NSError)

}

protocol ChatMessagesProvider {

    weak var delegate: ChatMessagesProviderDelegate? { get set }

    var chatMessages: [ChatMessage] { get }

    func updateMessages()
}

protocol ChatMessagesSender {

    func send(message: String, completion: (ErrorType?) -> Void)
    
}

protocol ChatMessagePresenter {

    func presentChatMessage(chatMessage: ChatMessage, inTableViewCell tableViewCell: UITableViewCell)

}

class ChatViewController: SLKTextViewController, ChatMessagesProviderDelegate {

    let chatMessagesProvider: ChatMessagesProvider
    let chatMessagePresenter: ChatMessagePresenter
    let chatMessageSender: ChatMessagesSender

    init(chatMessagesProvider: ChatMessagesProvider, chatMessagePresenter: ChatMessagePresenter, chatMessageSender: ChatMessagesSender) {
        self.chatMessagesProvider = chatMessagesProvider
        self.chatMessagePresenter = chatMessagePresenter
        self.chatMessageSender = chatMessageSender

        super.init(tableViewStyle: .Plain)

        self.chatMessagesProvider.delegate = self

        title = "UIKonf Chat"
        registerPrefixesForAutoCompletion(["@"])
    }

    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: "Cell")

        tableView?.tableFooterView = UIView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        chatMessagesProvider.updateMessages()
    }
    
    override func didPressRightButton(sender: AnyObject?) {
        chatMessageSender.send(self.textView.text) { [weak self] error in
            guard let _self = self else { return }
            guard error == nil else { return }

            _self.chatMessagesProvider.updateMessages()
        }
        super.didPressRightButton(sender)
    }

    //MARK: UITableView Delegate & Data Source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessagesProvider.chatMessages.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        cell.transform = tableView.transform
        chatMessagePresenter.presentChatMessage(chatMessagesProvider.chatMessages[indexPath.row], inTableViewCell: cell)
        return cell
    }

    //MARK: Chat Messages Provider Delegate

    func chatMessagesProviderWillBeginLoading(provider: ChatMessagesProvider) {
        //TODO: Display a nice spinner
    }

    func chatMessagesProviderDidFinishLoading(provider: ChatMessagesProvider) {
        tableView?.reloadData()
    }

    func chatMessagesProviderDid(provider: ChatMessagesProvider, didFailWithError error: NSError) {
        print("Error while updating messages: \(error)")
        //TODO: Let the user know?
    }
}
