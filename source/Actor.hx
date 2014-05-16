package ;
import flixel.FlxSprite;

/**
 * ...
 * @author Michael
 */
class Actor extends FlxSprite {

	public var seen : Bool;	
	public var speed : Float;
	
	public function new(x : Float, y : Float) {
		super(x, y);
		seen = false;
		speed = 30;
	}
	override public function update() {
		super.update();
		velocity.x = speed; 
	}
	public function die() {
		
	}
	
}