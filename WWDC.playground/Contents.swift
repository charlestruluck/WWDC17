import UIKit

/*:
 # Sandbox Mode Editor
 Edit the variables below, it will change how object look and move inside of the Sandbox Mode.
*/

let dynamics = Dynamics()
var color = Color.sand

//: Edit this! It will change the bounciness of the falling sand grains. Make the number a decimal between 0 and 1 (ex: 0.5)
dynamics.items.elasticity = 0.3
dynamics.items.friction = 1.0
dynamics.items.density = 1.0

//: Change this too! It'll change the sand grain color.
color = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)

TimelineManager(dynamics: dynamics, color: color)
//: Uncomment this line to go into interactive sandbox mode.
//TimelineManager(dynamics: dynamics, color: color).toView(2)
