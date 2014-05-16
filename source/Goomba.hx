package ;

/**
 * ...
 * @author Michael
 */
class Goomba extends Actor {

	
	public function new(x : Float, y : Float) {
		super(x,y);
		loadGraphic("images/goomba.png", true, 16, 16);
		animation.add("walk", [0, 1], 6);
		animation.add("die", [2,2,2,2]);
		animation.play("walk");
	}	
	
}