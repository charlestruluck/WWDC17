
// Basically the navigator.

import UIKit

class ProgrammingView: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
        backgroundColor = .clear
        finishedInitializing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func finishedInitializing() {
        setupSceneKit()
        
        let titleLabel = Utils.createLabel(text: "What I Do", fontSize: 32, frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 32))
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        let titles = ["Medical University of South Carolina", "Soteria", "Cyber Security", /*"Community Work"*/ "PGCTF17", "Sandbox Mode"]
        let descriptions = [
            "Confidential information removed for Github ;)",
            "While this information is not 'confidential', I'm trying to be mindful of sensitive information that I put on Github. Check out Soteria, the CyberSecurity company I intern at, on Google.",
            "One of my favorite subjects is Information Security because it's still a developing field. <There was stuff here but I removed it because it is also sensitive information>",
            // I removed this because I felt it was repetitive. I left it here in-case you guys actually read these. Maybe a little more information? Haha you've probably got better things to do; more people to judge!
            /*"Aside from my accomplishments, I run a number of operations to help others improve their technology skills. An example of this is the Porter-Gaud Cyber Security team, training for real-world incidence response. I also openly help any students struggling in the computer-science course by going more in-depth in core programming concepts.",*/
            "Another Porter-Gaud student and I developed and ran PGCTF, a hacking competition. It was scored using a jeopardy-style web interface. The subjects were exploitation, forensics, and reconnaissance competition for any schools looking to attend in the south-eastern United States. The competition was 100% free for everyone and there were 30 flags total. As an example, try to get this flag. It will be in wwdc{} format." /* A note for Github: The CTF problems are avalible on Tillson Galloway's account. Search for pgctf-problems on Github to find it :) */,
            "An area for playing!" // Never displays, just a placeholder for Sandbox Mode.
        ]
        
        let projects = ProjectObject(titles: titles, descriptions: descriptions, frame: CGRect(x: 30, y: 90, width: self.frame.width - 55, height: self.frame.height - 100))
        
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: self.center.x, y: 40)
        
        linePath.move(to: CGPoint(x: 30, y: 80))
        linePath.addLine(to: CGPoint(x: self.frame.width - 30, y: 80))
        
        line.path = linePath.cgPath
        line.strokeColor = UIColor.white.cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        
        projects.alpha = 0
        titleLabel.alpha = 0
        line.opacity = 0
        
        self.addSubview(projects)
        self.addSubview(titleLabel)
        self.layer.addSublayer(line)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) { 
            UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut, animations: { 
                projects.alpha = 1
                titleLabel.alpha = 1
                line.opacity = 1
            }, completion: nil)
        }
        
    }
    
    // Self explanitory by the name.
    func setupSceneKit() {
        let scene = Scene(frame: self.frame)
        scene.cameraNode.camera = scene.camera
        scene.setCameraPosition(x: 0.0, y: 1.5, z: 5.0)
        scene.setRootNodes()
        scene.sphereNode.addAnimation(scene.spin(), forKey: "spin around")
        scene.view.alpha = 0
        UIView.animate(withDuration: 3.0, delay: 0.0, options: .curveEaseIn, animations: {
            scene.view.alpha = 1
        }, completion: nil)
        self.addSubview(scene.view)
    }
    
    // Send to Sandbox Mode.
    func goToSandbox() {
        TimelineManager().toView(3)
    }
    
}

