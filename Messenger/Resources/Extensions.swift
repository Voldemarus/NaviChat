//
//  Extensions.swift
//  Messenger
//
//  Created by admin on 29.04.2022.
//

import Foundation
import UIKit

public func Loc(_ str : String) -> String {
    return NSLocalizedString(str, comment:"")
}

extension UIView {
    
    public var width : CGFloat {
        return self.frame.size.width
    }
   
    public var height : CGFloat {
        return self.frame.size.height
    }
    
    public var top : CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom : CGFloat {
        return height + top
    }

    public var left : CGFloat {
        return self.frame.origin.x
    }
    
    public var right : CGFloat {
        return width + left
    }
}

extension UITextField {
    public func textEntry( aTitle : String) -> UITextField {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.returnKeyType = .done
        let layer = tf.layer
        layer.cornerRadius = 12
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.lightGray.cgColor
        tf.placeholder = NSLocalizedString(aTitle, comment: "")
        tf.leftView = UIView(frame: CGRect(x:0, y:0, width:5, height:0))
        tf.leftViewMode = .always
        tf.backgroundColor = .white
        return tf
    }
}


extension UIButton {
    public func blueButton() -> UIButton {
        let b = UIButton()
        b.setTitle(NSLocalizedString("Log In", comment: ""), for: .normal)
        b.backgroundColor = .link
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 20.0, weight:.bold)
        let l = b.layer
        l.cornerRadius = 12
        l.masksToBounds = true
        return b
    }
}
