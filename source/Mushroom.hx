package ;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

/**
 * ...
 * @author Michael
 */
class Mushroom extends FlxSprite {

	public function new(X:Float=0, Y:Float=0)  {
		super(X, Y);
		solid = true;
		loadGraphic("images/stuff.png", false, 16, 16);
		animation.add("default", [0]);
		animation.play("default");
		acceleration.y = 750;
		velocity.y = -200;
	}
	
	override public function update() {
		super.update();
		velocity.x = 70;
	}
}