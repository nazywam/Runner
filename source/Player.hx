package;
import flash.geom.Point;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
/**
 * ...
 * @author Michael
 */
class Player extends FlxSprite {
	
	public var turnedRight : Bool;
	public var speed : Int;
	public var dead : Bool;
	public function new(x : Float, y : Float) {
		super(x, y);
		dead = false;
		solid = true;
		loadGraphic("images/player.png", false, 17, 16);
		initAnimation();
		animation.play("runRight");
		turnedRight = true;
		
		speed = 70;
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
		animation.add("die", [12,12,12], 5, false);
	}
	override public function update() {
		if (animation.name == "die") {
			if (animation.finished && !dead) {
				velocity.y = -250;
				acceleration.y = 350;
				dead = true;
			}
		}
		else if (velocity.x == 0 && velocity.y == 0) {
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
		velocity.x = speed;
		super.update();
	}
	public function die() {
		animation.play("die");
		speed = 0;
		solid = false;
		acceleration.y = 0;
	}
	
}