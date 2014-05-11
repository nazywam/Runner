package;

import flash.Lib;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;


class PlayState extends FlxState {
	
	var player : Player;
	
	var walls : FlxGroup;
	
	override public function create() {
		super.create();
		FlxG.log.redirectTraces = true;
		
		initWalls();
		
		
		player = new Player(100, 100);
		add(player);
	}
	private function initWalls() {
		walls = new FlxGroup();
		add(walls);
		var left = new FlxObject( -1, -1, 1, 500);
		var top = new FlxObject( -1, -1, 500, 1);
		var right = new FlxObject( 500, 0, 1, 500);
		var down = new FlxObject( 0, 500, 500, 1);
		walls.add(left);
		walls.add(top);
		walls.add(right);
		walls.add(down);
		for (x in walls) {
			cast(x, FlxObject).immovable = true;
		}
	}	
	override public function update() {
		super.update();
		FlxG.collide(player, walls, hitWall);
		if (FlxG.keys.justPressed.RIGHT) {
			player.turnedRight = true;
			player.crouching = false;
		}
		if (FlxG.keys.justPressed.LEFT) {
			player.turnedRight = false;
			player.crouching = false;
		}
		
		if (FlxG.keys.justPressed.UP && player.isTouching(FlxObject.ANY)) {
			player.velocity.y = -400;
			player.crouching = false;
		}
		
		if (!FlxG.keys.pressed.UP && player.velocity.y < 0) {
			player.velocity.y = 0;
		}
		
		if (FlxG.keys.pressed.LEFT) {
			player.velocity.x = -125;
		}
		if (FlxG.keys.pressed.RIGHT) {
			player.velocity.x = 125;
		}
		if (FlxG.keys.pressed.DOWN) {
			player.crouching = true;
		}
		if (FlxG.keys.justReleased.DOWN) {
			player.crouching = false;
		}
		
	}
	public function hitWall(player : Player, wall : FlxObject) {
		
	}
}