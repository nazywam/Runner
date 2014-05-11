package;
import flixel.FlxSprite;
import flixel.FlxObject;
/**
 * ...
 * @author Michael
 */
class Player extends FlxSprite {
	
	public var turnedRight : Bool;
	public var crouching : Bool;
	
	public function new(x : Float, y : Float) {
		super(x, y);
		loadGraphic("images/player.png", false, 50, 50);
		initAnimation();
		animation.play("runRight");
		turnedRight = true;
		
		drag.x = 750;
		acceleration.y = 750;
		//acceleration.x = 200;
		
	}
	private function initAnimation() {
		animation.add("standRight", [0]);
		animation.add("standLeft", [1]);
		animation.add("crouchRight", [2]);
		animation.add("crouchLeft", [3]);
		animation.add("jumpRight", [4]);
		animation.add("jumpLeft", [5]);
		animation.add("fallRight", [6]);
		animation.add("fallLeft", [7]);
		animation.add("runRight", [8, 9, 10, 11, 12, 13, 14 , 15], 10);
		animation.add("runLeft", [16, 17, 18, 19, 20, 21, 21, 22, 23], 10);
	}
	override public function update() {
		
		if (velocity.x == 0 && velocity.y == 0) {
			if (crouching) {
				if (turnedRight) animation.play("crouchRight");
				else animation.play("crouchLeft");
			} else {
				if (turnedRight) animation.play("standRight");
				else animation.play("standLeft");
			}
		}	
		else if (!isTouching(FlxObject.FLOOR)) {
			if (turnedRight) animation.play("jumpRight");
			else animation.play("jumpLeft");
		} else {
			if (turnedRight) animation.play("runRight");
			else animation.play("runLeft");
		}
		
		super.update();
	}
	
}