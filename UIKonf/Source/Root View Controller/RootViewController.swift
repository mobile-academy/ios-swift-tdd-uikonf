//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {

    let containedNavigationController: UINavigationController

    init() {
        containedNavigationController = UINavigationController()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(containedNavigationController)
        view.addSubview(containedNavigationController.view)
        containedNavigationController.view.ma_pinToSuperviewAnchors()
        containedNavigationController.didMoveToParentViewController(self)

        containedNavigationController.viewControllers = [makeChatViewController()]
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    //MARK: Other

    private func makeChatViewController() -> UIViewController {
        let chatMessagesProvider = DefaultChatMessagesProvider()
        let chatMessagePresenter = DefaultChatMessagePresenter()
        let chatMessageSender = DefaultChatMessagesSender()

        let chatViewController = ChatViewController(chatMessagesProvider: chatMessagesProvider, chatMessagePresenter: chatMessagePresenter, chatMessageSender: chatMessageSender)
        return chatViewController
    }
}
