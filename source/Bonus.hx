package ;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Michael
 */
class Bonus extends Box {

	var mushrooms : FlxGroup;
	
	public function new(x:Int, y:Int, mushrooms : FlxGroup ) {
		super(x, y);
		this.mushrooms = mushrooms;
		loadGraphic("images/stuff.png", true, 16, 16);
		animation.add("default", [5, 5, 5, 7, 6], 5);
		animation.add("used", [2]);
		animation.play("default");
	}
	override public function hit() {
		super.hit();
		mushrooms.add(new Mushroom(x, y-8));
	}
	
}