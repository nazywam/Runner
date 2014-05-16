package ;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

/**
 * ...
 * @author Michael
 */
class Box extends FlxSprite{
	public function new(x : Int, y : Int) {
		super(x, y);
		immovable = true;

	}
	public function hit() {
		
		animation.play("used");
			
		var a = new Array<FlxPoint>();
		a.push(new FlxPoint(x, y));
		a.push(new FlxPoint(x, y - 7));
		a.push(new FlxPoint(x, y));
			
		FlxTween.linearPath(this, a, 0.6, true, { type : FlxTween.ONESHOT, ease:FlxEase.bounceOut} );
			
	}

}