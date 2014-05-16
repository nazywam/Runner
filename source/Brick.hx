package ;

/**
 * ...
 * @author Michael
 */
class Brick extends Box {

	public function new(x:Int, y:Int) {
		super(x, y);
		loadGraphic("images/tiles.png", false, 16, 16);
		animation.add("default", [125]);
		animation.add("used", [125]);
		animation.play("default");
	}
	
}