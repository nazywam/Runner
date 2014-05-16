package ;

/**
 * ...
 * @author Michael
 */
import flixel.tweens.FlxTween;
class Goomba extends Actor {

	
	public function new(x : Float, y : Float) {
		super(x,y);
		loadGraphic("images/goomba.png", true, 16, 16);
		animation.add("walk", [0, 1], 6);
		animation.add("die", [2, 2, 2], 5, false);
		animation.play("walk");
	}
	override public function die() {	
		animation.play("die");
		speed = 0;
	}
	override public function update() {
		super.update();
		trace(animation.finished);
		if (animation.name == "die" && animation.finished) {
			super.kill();
		}
	}
}