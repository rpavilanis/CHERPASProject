//
//  DayOverviewTableViewCell.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/6/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit

class DayOverviewTableViewCell: UITableViewCell {
    
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  

//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        // add a pan recognizer
//        let recognizer = UIPanGestureRecognizer(target: self, action: Selector(("handlePan:")))
//        recognizer.delegate = self
//        addGestureRecognizer(recognizer)
//    
//    }
//    
//    
//    //MARK: - horizontal pan gesture methods
//    func handlePan(recognizer: UIPanGestureRecognizer) {
//        // 1
//        if recognizer.state == .began {
//            // when the gesture begins, record the current center location
//            originalCenter = center
//        }
//        // 2
//        if recognizer.state == .changed {
////            let translation = recognizer.translation(in: self)
////            center = CGPoint(originalCenter.x + translation.x, originalCenter.y)
//            // has the user dragged the item far enough to initiate a delete/complete?
//            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
//        }
//        // 3
//        if recognizer.state == .ended {
//            // the frame this cell had before user dragged it
//            let originalFrame = CGRect(x: 0, y: frame.origin.y,
//                                       width: bounds.size.width, height: bounds.size.height)
//            if !deleteOnDragRelease {
//                // if the item is not being deleted, snap back to the original location
//                UIView.animate(withDuration: 0.2, animations: {self.frame = originalFrame})
//            }
//        }
//    }
//    
//    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
//            let translation = panGestureRecognizer.translation(in: superview!)
//            if fabs(translation.x) > fabs(translation.y) {
//                return true
//            }
//            return false
//        }
//        return false
//    }

    
}
