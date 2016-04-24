//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class DefaultChatMessagePresenter: ChatMessagePresenter {

    func presentChatMessage(chatMessage: ChatMessage, inTableViewCell tableViewCell: UITableViewCell) {
        tableViewCell.textLabel?.text = chatMessage.text
    }
}
