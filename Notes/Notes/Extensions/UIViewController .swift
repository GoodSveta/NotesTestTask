//
//  UIViewController .swift
//  Notes
//
//  Created by mac on 21.12.22.
//

import UIKit

extension UIViewController {
    static var getInstanceViewController: UIViewController? {
        return UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController()
    }
    
    static func getViewController(with identifier: String) -> UIViewController? {
        return UIStoryboard(name: String(describing: self), bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}

extension NotesViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}


extension UIColor {
    
    class func color(data:Data) -> UIColor? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }
    
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}

extension UIFont {
    
    class func font(data:Data) -> UIFont? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIFont
    }
    
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}
