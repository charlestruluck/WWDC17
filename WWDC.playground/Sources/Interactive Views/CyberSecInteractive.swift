
// ROT13 interactive. PLEASE- for everyone's sake, DO NOT use ROT13 in production projects. heheh.

import UIKit

class CyberSecInteractive: UIView, UITextFieldDelegate {
    
    var textField = UITextField()
    var rot13Text = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        finishedInitializing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func finishedInitializing() {
        
        let desc = Utils.createLabel(text: "ROT13 means rotate by 13 places. It is a simple letter substitution cipher which replaces each letter with the letter 13 characters after it. You can try it out above!", fontSize: 16, frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 86))
        
        textField = Utils.createTextField(placeholder: "rot13 converter", frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 38))
        textField.addTarget(self, action: #selector(didReturn), for: .allEvents)
        
        rot13Text = Utils.createLabel(text: "", fontSize: 32, frame: textField.frame)
        rot13Text.center = CGPoint(x: self.center.x, y: textField.center.y + 38)
        
        desc.frame.origin.y = rot13Text.frame.origin.y + rot13Text.frame.height + 16
        desc.numberOfLines = 0
        desc.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        
        self.addSubview(textField)
        self.addSubview(rot13Text)
        self.addSubview(desc)
        
    }
    
    // The reason I am using ROT13 and not SHA256 or 512 is that we have to code this entire Playground ourselves...
    func didReturn(sender: UITextField) {
        rot13Text.text = rot13(sender.text!)
    }
    
    func rot13(unicodeScalar: UnicodeScalar) -> UnicodeScalar {
        var result = unicodeScalar.value
        
        if 65...90 ~= result {
            result = (result + 13 - 65) % 26 + 65
        }
        else if 97 ... 122 ~= result {
            result = (result + 13 - 97) % 26 + 97
        }
        
        return UnicodeScalar(result)!
    }
    
    func rot13(_ input: String) -> String {
        let resultUSs = input.unicodeScalars.map(rot13)
        
        var resultUSV = String.UnicodeScalarView()
        resultUSV.append(contentsOf: resultUSs)
        return String(resultUSV)
    }
    
}
