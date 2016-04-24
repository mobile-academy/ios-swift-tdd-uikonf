//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func ma_pinToSuperviewAnchors() {
        if let superview = superview {
            topAnchor.constraintEqualToAnchor(superview.topAnchor)
            leadingAnchor.constraintEqualToAnchor(superview.leadingAnchor)
            trailingAnchor.constraintEqualToAnchor(superview.trailingAnchor)
            bottomAnchor.constraintEqualToAnchor(superview.bottomAnchor)
        } else {
            fatalError("Attempted to pin to superview anchors, but no superview is defined!")
        }
    }

}
