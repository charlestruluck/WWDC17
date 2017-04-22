
// UIKit Dynamics stuff

import UIKit

open class Dynamics {
    
    open var animator = UIDynamicAnimator()
    open var collision = UICollisionBehavior()
    open var gravity = UIGravityBehavior()
    open var items = UIDynamicItemBehavior()
    
    public init() {
        self.animator = UIDynamicAnimator()
        self.collision = UICollisionBehavior(items: [])
        self.gravity = UIGravityBehavior(items: [])
        self.items = UIDynamicItemBehavior(items: [])
        
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
        animator.addBehavior(items)
    }
    
    // Add an object to ItemBehavior, GravityBehavior, and CollisionBehavior.
    func addObject(object: UIDynamicItem) {
        items.addItem(object)
        collision.addItem(object)
        gravity.addItem(object)
    }
    
    // Remove an object from ItemBehavior, GravityBehavior, and CollisionBehavior.
    func removeObject(object: UIDynamicItem) {
        items.removeItem(object)
        collision.removeItem(object)
        gravity.removeItem(object)
    }
    
}
