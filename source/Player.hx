package;
import flixel.FlxSprite;
import flixel.FlxObject;
/**
 * ...
 * @author Michael
 */
class Player extends FlxSprite {
	
	public var turnedRight : Bool;
	
	public function new(x : Float, y : Float) {
		super(x, y);
		solid = true;
		loadGraphic("images/player.png", false, 17, 16);
		initAnimation();
		animation.play("runRight");
		turnedRight = true;
		
		drag.x = 750;
		acceleration.y = 750;
		//acceleration.x = 200;
		
	}
	private function initAnimation() {
		animation.add("standRight", [6]);
		animation.add("standLeft", [5]);
		animation.add("jumpRight", [11]);
		animation.add("jumpLeft", [0]);
		animation.add("runRight", [7,8,9], 10);
		animation.add("runLeft", [2, 3, 4], 10);
	}
	override public function update() {
		
		if (velocity.x == 0 && velocity.y == 0) {
			if (turnedRight) animation.play("standRight");
			else animation.play("standLeft");
		}	
		else if (!isTouching(FlxObject.FLOOR)) {
			if (turnedRight) animation.play("jumpRight");
			else animation.play("jumpLeft");
		} else {
			if (turnedRight) animation.play("runRight");
			else animation.play("runLeft");
		}
		velocity.x = 70;
		super.update();
	}
	
}