package;

import flash.Lib;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.tile.FlxTile;
import openfl.Assets;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;



class PlayState extends FlxState {
	
	//16x14
	
	var player : Player;
	var map : FlxTilemap;
	var background : FlxSprite;
	
	var bonuses : FlxGroup;
	var bricks : FlxGroup;
	var mushrooms : FlxGroup;
	var goombas : FlxGroup;
	override public function create() {
		super.create();
		FlxG.log.redirectTraces = true;
		FlxG.worldBounds.set(0, 0, 3392, 224);
		
		background = new FlxSprite();
		background.loadGraphic("images/background.png");
		add(background);
		
		map = new FlxTilemap();
		map.loadMap(Assets.getText("data/map.txt"), "images/tiles.png", 16, 16, 0, 1);
		add(map);
		
		player = new Player(60, 150);
		add(player);
		//FlxG.camera.follow(player);
		
		bonuses = new FlxGroup();
		add(bonuses);
		
		bricks = new FlxGroup();
		add(bricks);
		
		mushrooms = new FlxGroup();
		add(mushrooms);
		
		goombas = new FlxGroup();
		add(goombas);
		
		placeBoxes(Assets.getText("data/boxes.csv"));
	}
	public function hitBox(player : Player, box : Box) {
		if (box.animation.name != "used" && box.isTouching(FlxObject.FLOOR)) {
			box.hit();			
		}
	}
	public function eatShroom(player : Player, shroom : Mushroom) {
		FlxG.camera.shake();
		FlxG.camera.angle = Std.random(10) - 5;
		FlxG.camera.flash();
		mushrooms.remove(shroom);
	}
	public function actorHitWall(actor : Actor, a : FlxTilemap) {
		actor.speed = -actor.speed;		
	}
	public function actorHitActor(a1 : Actor, a2 : Actor) {
		a1.speed = -a1.speed;
		a2.speed = -a2.speed;
	}
	public function playerHitActor(player : Player, actor : Actor){
		if (actor.isTouching(FlxObject.CEILING)) {
			actor.animation.play("die");
			player.velocity.y = -200;
			goombas.remove(actor);
		}
	}
	override public function update() {
		super.update();
		
		//FlxG.camera.angle += 0.1;
		
		//FlxG.camera.scroll.x +=1;
		
		FlxG.collide(player, map);
		FlxG.collide(player, bonuses, hitBox);
		FlxG.collide(player, bricks, hitBox);
		FlxG.collide(mushrooms, bricks);
		FlxG.collide(mushrooms, bonuses);
		FlxG.collide(mushrooms, map);
		FlxG.collide(player, goombas, playerHitActor);
		FlxG.collide(goombas, map, actorHitWall);
		FlxG.overlap(player, mushrooms, eatShroom);
		FlxG.collide(goombas, goombas, actorHitActor);
		
		if (FlxG.keys.pressed.RIGHT) {
			FlxG.camera.scroll.x += 10;
		}
		if (FlxG.keys.pressed.LEFT) {
			FlxG.camera.scroll.x -= 11;
		}
		
		if ((FlxG.keys.justPressed.UP || FlxG.mouse.justPressed) && player.isTouching(FlxObject.FLOOR)) {
			player.velocity.y = -333;
		}
		
		if ( (FlxG.keys.justReleased.UP || FlxG.mouse.justReleased) && player.velocity.y < 0) {
			player.velocity.y = 0;
		}		
	}
	public function placeBoxes(BoxData:String) {
		var coords:Array<String>;
		var entities:Array<String> = BoxData.split("\n");   
		
		for (y in 0...(entities.length)) {
			coords = entities[y].split(",");  
			for (x in 0...(coords.length)) {
				if (Std.parseInt(coords[x]) == 141) {
					bonuses.add(new Bonus(x*16, y*16, mushrooms)); 
				}
				if (Std.parseInt(coords[x]) == 126) {
					bricks.add(new Brick(x*16, y*16)); 
				}
				if (Std.parseInt(coords[x]) == 128) {
					goombas.add(new Goomba(x*16, y*16)); 
				}
			}
				
		}
	}
}