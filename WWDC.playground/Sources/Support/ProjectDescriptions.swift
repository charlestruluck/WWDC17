
// Addon to Projects.swift, in a seperate file to help myself stay organized.

import UIKit

class ProjectDescription: UIView {
    
    var projectTitle: String
    let projectDescription: String
    
    var title = UILabel()
    var back = UIButton()
    var text = UILabel()
    
    private let dynamics = Dynamics()
    
    init(title: String, description: String, frame: CGRect) {
        self.projectTitle = title
        self.projectDescription = description
        
        super.init(frame: frame)
        
        alpha = 0
        backgroundColor = Color.civic
        dynamics.gravity.gravityDirection = CGVector(dx: 0.0, dy: -1.0)
        finishedInitializing()
    }
    
    func finishedInitializing() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: { 
            self.alpha = 1
        }, completion: nil)

        title = Utils.createLabel(text: projectTitle, fontSize: 32, frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 32))
        back = Utils.createButton(text: "Back", fontSize: 24, frame: CGRect(x: 0, y: 4, width: 60, height: 24))
        text = UILabel(frame: CGRect(x: 0, y: 32, width: self.frame.width, height: self.frame.height - 32))
        
        text.text = projectDescription
        
        // A dirty way to override titles and body text.
        if title.text == "Medical University of South Carolina" {
            title.text = "MUSC"
        } else if title.text == "Community Work" {
            title.text = "Community"
        } else if title.text == "Cyber Security" {
            title.text = "Cyber Sec."
        } else if title.text == "Sandbox Mode" {
            title.text = ""
            text.text = ""
        }
        
        title.sizeToFit()
        title.center = CGPoint(x: self.center.x, y: 16)
        
        back.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightBold)
        back.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        
        text.font = UIFont.systemFont(ofSize: 19, weight: UIFontWeightRegular)
        text.numberOfLines = 0
        text.textAlignment = .natural
        text.sizeToFit()
        text.textColor = .white
        text.backgroundColor = .clear
        text.frame.origin.y = 40
        text.textColor = .gray
        
        addSubview(title)
        addSubview(text)
        addSubview(back)
        
        interactionSection(title: title.text!)
    }
    
    // For the CTF. Also, I just think the ROT13 part is cool.
    func interactionSection(title: String) {
        let frame = CGRect(x: 0, y: self.frame.height / 2, width: self.frame.width, height: self.frame.height / 2)
        var interactiveContainer = UIView()
        
        if title == "Cyber Sec." {
            interactiveContainer = CyberSecInteractive(frame: frame)
        } else if title == "PGCTF17" {
            interactiveContainer = PGCTFInteractive(frame: frame)
        }
        
        self.addSubview(interactiveContainer)
    }
    
    // Hide self (the title, body text, etc) and reveal the TableView again.
    func backPressed(sender: UIButton) {
        dynamics.addObject(object: self)
        UIView.animate(withDuration: 0.3, animations: { 
            self.alpha = 0
        }) { (true) in
            self.dynamics.removeObject(object: self)
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
