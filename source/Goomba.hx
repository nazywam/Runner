package ;

/**
 * ...
 * @author Michael
 */
import flixel.effects.particles.FlxEmitter;
import flixel.tweens.FlxTween;
class Goomba extends Actor {

	var gibs : FlxEmitter;
	
	public function new(x : Float, y : Float, gibs : FlxEmitter) {
		super(x, y);
		
		this.gibs = gibs;
		
		loadGraphic("images/goomba.png", true, 16, 16);
		animation.add("walk", [0, 1], 6);
		animation.add("die", [2, 2, 2], 5, false);
		animation.play("walk");
		
		width = 8;
		height = 12;
		offset.x = 4;
		offset.y = 4;
		
	}
	override public function die() {	
		animation.play("die");
		speed = 0;
		gibs.at(this);
		gibs.start(true, 8, 2, 15);
	}
	override public function update() {
		super.update();
		if (animation.name == "die" && animation.finished) {
			super.kill();
		}
	}
}