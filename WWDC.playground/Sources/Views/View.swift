
// Intro UIView. Not much to see here.

import UIKit

class View: UIView {
    
    var directDynamics = Dynamics()
    var inverseDynamics = Dynamics()
    var welcomeButton = UIButton()
    var oppositeWelcome = UIButton()
    var didRunIntro = false
    var runNumber = 0
    var topCenter = CGPoint()
    var botCenter = CGPoint()
    var topContainer = UIView()
    var botContainer = UIView()
    var divider = CAShapeLayer()
    var hintLabel = UILabel()
    var charlesButton = UIButton()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
        
        topCenter = CGPoint(x: self.center.x, y: self.frame.height/4)
        botCenter = CGPoint(x: self.center.x, y: self.frame.height/1.4)
        
        backgroundColor = Color.black
        
        directDynamics.gravity.gravityDirection = CGVector(dx: 0.0, dy: 1.0)
        inverseDynamics.gravity.gravityDirection = CGVector(dx: 0.0, dy: -1.0)
        
        directDynamics.items.friction = 0
        inverseDynamics.items.friction = 0
        
        directDynamics.items.density = 1
        inverseDynamics.items.density = 1
        
        directDynamics.items.elasticity = 0.5
        inverseDynamics.items.elasticity = 0.5
        
        finishedInitializing()
    }
    
    func finishedInitializing() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
        
        welcomeButton = Utils.createButton(text: "Hello", fontSize: 64, frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 84))
        oppositeWelcome = Utils.createButton(text: "Hello", fontSize: 64, frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 84))
        let dividerPath = UIBezierPath()
        hintLabel = Utils.createLabel(text: "touch to continue", fontSize: 14, frame: CGRect(x: 0, y: self.frame.height - 24, width: self.frame.width, height: 14))
        
        dividerPath.move(to: CGPoint(x: 0, y: self.frame.height/2.1))
        dividerPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height/1.9))
        
        divider.path = dividerPath.cgPath
        divider.strokeColor = UIColor.white.cgColor
        divider.lineWidth = 2
        divider.lineJoin = kCALineJoinRound
        
        welcomeButton.sizeToFit()
        welcomeButton.center = topCenter
        welcomeButton.setTitleColor(.white, for: .normal)
        welcomeButton.tag = 0
        welcomeButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        oppositeWelcome.sizeToFit()
        oppositeWelcome.center = botCenter
        oppositeWelcome.transform = CGAffineTransform(scaleX: -1.0, y: -1.0)
        oppositeWelcome.setTitleColor(.white, for: .normal)
        oppositeWelcome.tag = 1
        oppositeWelcome.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        hintLabel.textAlignment = .center
        hintLabel.alpha = 0.5
        
        self.layer.addSublayer(divider)
        self.addSubview(oppositeWelcome)
        self.addSubview(welcomeButton)
        self.addSubview(hintLabel)
        
        directDynamics.collision.addBoundary(withIdentifier: "divider" as NSCopying, from: CGPoint(x: 0, y: self.frame.height/2.1), to: CGPoint(x: self.frame.width, y: self.frame.height/1.9))
        inverseDynamics.collision.addBoundary(withIdentifier: "divider" as NSCopying, from: CGPoint(x: 0, y: self.frame.height/2.1), to: CGPoint(x: self.frame.width, y: self.frame.height/1.9))
        
    }
    
    // Runs the below function (buttonPressed)
    func handleTap() {
        welcomeButton.sendActions(for: .touchUpInside)
    }
    
    // Splits all the letters in the 'Hello' text to be independant, then adds then to the array of UIKitDynamics objects.
    func buttonPressed(sender: UIButton) {
        let charString = sender.titleLabel!.text!
        let letters = [Character](charString.characters)
        for (i, c) in letters.enumerated() {
            sender.isHidden = true
            var characterLabel = UILabel()
            switch c {
            case "H":
                characterLabel = Utils.createLabel(text: String(describing: c), fontSize: 64, frame: CGRect(x: (sender.frame.origin.x) + CGFloat(i * 26), y: sender.frame.origin.y, width: 42, height: 48))
            case "e":
                characterLabel = Utils.createLabel(text: String(describing: c), fontSize: 64, frame: CGRect(x: (sender.frame.origin.x) + CGFloat(i * 26), y: sender.frame.origin.y, width: 38, height: 48))
            case "l":
                characterLabel = Utils.createLabel(text: String(describing: c), fontSize: 64, frame: CGRect(x: (sender.frame.origin.x) + 52, y: sender.frame.origin.y, width: 10, height: 48))
            case "o":
                characterLabel = Utils.createLabel(text: String(describing: c), fontSize: 64, frame: CGRect(x: (sender.frame.origin.x) + CGFloat(i * 26), y: sender.frame.origin.y, width: 38, height: 48))
            default:
                break
            }
            self.addSubview(characterLabel)
            switch sender.tag {
            case 1:
                characterLabel.transform = CGAffineTransform(scaleX: -1.0, y: -1.0)
                if didRunIntro == false {
                    didRunIntro = true
                    welcomeButton.sendActions(for: .touchUpInside)
                }
                inverseDynamics.addObject(object: characterLabel)
            default:
                if didRunIntro == false {
                    didRunIntro = true
                    oppositeWelcome.sendActions(for: .touchUpInside)
                }
                directDynamics.addObject(object: characterLabel)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.3) {
            self.runNumber += 1
            if self.runNumber == 2 {
                self.secondPhase()
                self.hintLabel.removeFromSuperview()
            }
        }
    }
    
    // Second phase of the intro.
    func secondPhase() {
        topContainer = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/1.9))
        botContainer = UIView(frame: CGRect(x: 0, y: self.frame.height/1.9, width: self.frame.width, height: self.frame.height/1.9))
        let hintLabelSubView = Utils.createLabel(text: "touch to continue", fontSize: 14, frame: CGRect(x: 0, y: botContainer.frame.height - 54, width: botContainer.frame.width, height: 14))
        let segmentTop = CAShapeLayer()
        let segmentPathTop = UIBezierPath()
        let segmentBot = CAShapeLayer()
        let segmentPathBot = UIBezierPath()
        charlesButton = Utils.createButton(text: "I'm Charles", fontSize: 64, frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 64))
        let iAmLabel = Utils.createLabel(text: "15 years old", fontSize: 40, frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 250))
        let tap = UITapGestureRecognizer(target: self, action: #selector(secondHandleTap))
        
        charlesButton.center = topCenter
        charlesButton.setTitleColor(.white, for: .normal)
        charlesButton.addTarget(self, action: #selector(charlesButtonPressed), for: .touchUpInside)
        
        iAmLabel.numberOfLines = 2
        iAmLabel.textAlignment = .center
        
        segmentPathTop.move(to: CGPoint(x: 0, y: 0))
        segmentPathTop.addLine(to: CGPoint(x: self.frame.width, y: 0))
        segmentPathTop.addLine(to: CGPoint(x: self.frame.width, y: (self.frame.height/1.9) - 1))
        segmentPathTop.addLine(to: CGPoint(x: 0, y: (self.frame.height/2.1) - 1))
        segmentPathBot.move(to: CGPoint(x: botContainer.frame.width, y: 2))
        segmentPathBot.addLine(to: CGPoint(x: 0, y: -28))
        segmentPathBot.addLine(to: CGPoint(x: 0, y: botContainer.frame.height))
        segmentPathBot.addLine(to: CGPoint(x: botContainer.frame.width, y: botContainer.frame.height))
        
        segmentTop.path = segmentPathTop.cgPath
        segmentTop.fillColor = Color.black.cgColor
        segmentTop.lineJoin = kCALineJoinRound
        segmentBot.path = segmentPathBot.cgPath
        segmentBot.fillColor = Color.red.cgColor
        segmentBot.lineJoin = kCALineJoinRound
        
        hintLabelSubView.textAlignment = .center
        hintLabelSubView.alpha = 0.5
        
        topContainer.layer.addSublayer(segmentTop)
        botContainer.layer.addSublayer(segmentBot)
        topContainer.addSubview(charlesButton)
        botContainer.addSubview(iAmLabel)
        botContainer.addSubview(hintLabelSubView)
        botContainer.alpha = 0
        topContainer.alpha = 0

        self.addSubview(topContainer)
        self.addSubview(botContainer)
        self.addGestureRecognizer(tap)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: { 
            self.botContainer.alpha = 1
            self.topContainer.alpha = 1
        }, completion: nil)
        
    }
    
    // Ran when tapped on the second part of the intro. Runs the function below. (charlesButtonPressed)
    func secondHandleTap() {
        charlesButton.sendActions(for: .touchUpInside)
    }
    
    // Splits the two different containers apart, so it's animated.
    func charlesButtonPressed(sender: UIButton) {
        self.backgroundColor = Color.civic
        hintLabel.removeFromSuperview()
        
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseInOut, animations: { 
            self.topContainer.frame.origin.y = -300
            self.botContainer.frame.origin.y = 900
            self.divider.opacity = 0
        }) { (true) in
            TimelineManager().secondView()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
