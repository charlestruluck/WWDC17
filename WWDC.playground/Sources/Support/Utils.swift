
// Utilities for easily creating and formatting objects.

import UIKit

class Utils {
    
    // simplify creation of buttons.
    class func createButton(text: String, fontSize: CGFloat, frame: CGRect) -> UIButton {
        let button = UIButton()
        button.frame = frame
        button.setTitle(text, for: .normal)
        button.setTitleColor(Color.button, for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightRegular)
        return button
    }
    
    // Simplify creation of labels.
    class func createLabel(text: String, fontSize: CGFloat, frame: CGRect) -> UILabel {
        let label = UILabel()
        label.frame = frame
        label.text = text
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFontWeightBold)
        label.textColor = .white
        return label
    }
    
    // Create a text field. Made to transfer styling between both of the UITextFields I used.
    class func createTextField(placeholder: String, frame: CGRect) -> UITextField {
        let textField = UITextField()
        let textFieldUnderlinePath = UIBezierPath()
        let textFieldUnderline = CAShapeLayer()
        textField.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightThin)
        textField.frame = frame
        textField.clearsOnBeginEditing = true
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.inputView = UIView()
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: UIColor.gray])
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textFieldUnderlinePath.move(to: CGPoint(x: textField.frame.origin.x, y: textField.frame.origin.y + textField.frame.height))
        textFieldUnderlinePath.addLine(to: CGPoint(x: textField.frame.origin.x + textField.frame.width, y: textField.frame.origin.y + textField.frame.height))
        textFieldUnderline.path = textFieldUnderlinePath.cgPath
        textFieldUnderline.strokeColor = UIColor.white.cgColor
        textFieldUnderline.lineWidth = 2
        textFieldUnderline.lineJoin = kCALineJoinRound
        textField.layer.addSublayer(textFieldUnderline)
        return textField
    }
    
}
