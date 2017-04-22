
// A simple, dirtily-done controller for which view is being displayed.

import UIKit
import PlaygroundSupport

public class TimelineManager {
    
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
    let introView = View()
    let programmingView = ProgrammingView()
    let sandboxView: Sandbox
    
    public init(dynamics: Dynamics = Dynamics(), color: UIColor = Color.sand) {
        self.sandboxView = Sandbox(dynamics: dynamics, color: color)
        container.backgroundColor = Color.civic
        PlaygroundPage.current.liveView = container
        container.addSubview(introView)
    }
    
    // Used to animate the transition, to make it smoother.
    func secondView() {
        programmingView.alpha = 0
        introView.removeFromSuperview()
        container.addSubview(programmingView)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.programmingView.alpha = 1
        }, completion: nil)
    }
    
    // Send to a section of my playground.
    public func toView(_ view: Int) {
        for subview in container.subviews { subview.removeFromSuperview() }
        switch view {
        case 0:
            container.addSubview(introView)
        case 1:
            container.addSubview(programmingView)
        case 2:
            container.addSubview(sandboxView)
        default:
            container.addSubview(programmingView)
        }
    }
    
}
