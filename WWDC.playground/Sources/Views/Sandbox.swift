
// A fun, interactive part of my playground.

import UIKit

open class Sandbox: UIView, UICollisionBehaviorDelegate {
    
    var dynamics = Dynamics()
    var color = UIColor()
    var lastTapPosition = Int()
    
    init(dynamics: Dynamics, color: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
        
        dynamics.collision.collisionDelegate = self
        dynamics.collision.addBoundary(withIdentifier: "border" as NSCopying, for: UIBezierPath(rect: self.frame))
        dynamics.items.allowsRotation = false
        
        self.dynamics = dynamics
        self.color = color
        
        finishedInitializing()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func finishedInitializing() {
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(booped))
        let sandbox = Utils.createLabel(text: "SANDBOX", fontSize: 32, frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 32))
        let sandboxDesc = Utils.createLabel(text: "drag to drizzle", fontSize: 14, frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 14))
        let backButton = Utils.createButton(text: "Back", fontSize: 24, frame: CGRect(x: 0, y: 10, width: 96, height: 24))
        
        sandbox.center = CGPoint(x: self.center.x, y: self.frame.height / 1.4)
        sandbox.textColor = .white
        sandbox.textAlignment = .center
        sandbox.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightHeavy)
        
        sandboxDesc.center = CGPoint(x: self.center.x, y: sandbox.frame.origin.y + 42)
        sandboxDesc.textColor = .white
        sandboxDesc.textAlignment = .center
        sandboxDesc.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
        
        tap.minimumPressDuration = 0.001
        
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightBold)
        
        self.addGestureRecognizer(tap)
        self.insertSubview(sandbox, at: 1)
        self.insertSubview(sandboxDesc, at: 0)
        self.insertSubview(backButton, at: 1000)
    }
    
    // Gets where the user taps/moves their finger to.
    func booped(tap: UILongPressGestureRecognizer) {
        var boopLocation = tap.location(in: self)
        if boopLocation.x < 96 && boopLocation.y < 32 { goBack() }
        boopLocation = CGPoint(x: boopLocation.x, y: 4)
        
        if lastTapPosition != roundToEight(value: Int(boopLocation.x)) {
            lastTapPosition = roundToEight(value: Int(boopLocation.x))
            
            let sandGrain = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            sandGrain.backgroundColor = self.color
            sandGrain.frame.origin = CGPoint(x: roundToEight(value: Int(boopLocation.x)), y: 0)
            self.insertSubview(sandGrain, at: 2)
            
            dynamics.addObject(object: sandGrain)
        }
        
    }
    
    // This function is used to seperate the UIViews (send grains) into columns.
    func roundToEight(value: Int) -> Int{
        let fractionNum = Double(value) / 16.0
        let roundedNum = Int(ceil(fractionNum))
        return roundedNum * 16
    }
    
    // Send back to ProgrammingView.
    func goBack() {
        TimelineManager().toView(1)
    }
    
}

