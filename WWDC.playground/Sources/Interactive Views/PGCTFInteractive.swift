
// PGCTF Interactive: Incorporates the mini-capture the flag.

import UIKit

class PGCTFInteractive: UIView {
    
    var question = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        finishedInitializing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func finishedInitializing() {
        question = Utils.createLabel(text: "jjqp{guvf_vf_n_synt}", fontSize: 32, frame: CGRect(x: 0, y: 64, width: self.frame.width, height: 38))
        let textField = Utils.createTextField(placeholder: "insert flag here", frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 32))
        let desc = Utils.createLabel(text: "Obscured by ROT13, try to get the flag with the converter!", fontSize: 24, frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 64))
        
        question.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightThin)
        question.textAlignment = .center
        textField.center = CGPoint(x: textField.center.x, y: self.frame.height - 82)
        textField.addTarget(self, action: #selector(didEdit), for: .allEvents)
        desc.center = CGPoint(x: self.center.x, y: textField.center.y + 48)
        desc.numberOfLines = 0
        
        self.addSubview(question)
        self.addSubview(textField)
        self.addSubview(desc)
    }
    
    // Check to see if the flag is right whenever someone writes text.
    func didEdit(sender: UITextField) {
        if sender.text == "wwdc{this_is_a_flag}" || sender.text == "this_is_a_flag" {
            sender.textColor = .green
            question.text = "✓"
            question.font = UIFont.systemFont(ofSize: 128)
            question.frame = CGRect(x: question.frame.origin.x, y: question.frame.origin.y, width: question.frame.width, height: 84)
            
        } else {
            sender.textColor = .white
            
            question.text = "jjqp{guvf_vf_n_synt}"
            question.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightThin)
            question.frame = CGRect(x: question.frame.origin.x, y: question.frame.origin.y, width: question.frame.width, height: 38)
        }
    }
    
}
