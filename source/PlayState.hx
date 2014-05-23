package;

import flixel.util.FlxRect;
import flash.Lib;
import flixel.effects.particles.FlxEmitter;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.tile.FlxTile;
import flixel.util.FlxPoint;
import openfl.Assets;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;

import flixel.addons.effects.FlxGlitchSprite;

class PlayState extends FlxState {
	
	var player : Player;
	var map : FlxTilemap;
	var background : FlxSprite;
	
	var bonuses : FlxGroup;
	var bricks : FlxGroup;
	var mushrooms : FlxGroup;
	var goombas : FlxGroup;
	
	var scrollSpeed : Float;
	
	var gibs : FlxEmitter;
	
	var glitch : FlxGlitchSprite;
	override public function create() {
		super.create();
		FlxG.log.redirectTraces = true;
		FlxG.mouse.visible = false;
		FlxG.worldBounds.set(0, 0, 3392, 224);
		
		scrollSpeed = 1;
		
		background = new FlxSprite();
		background.loadGraphic("images/background.png");
		add(background);
		
		glitch = new FlxGlitchSprite(background, 1, 4);
		add(glitch);
		glitch.visible = false;

		
		gibs = new FlxEmitter(100, 100);
		gibs.makeParticles("images/gibs.png", 50, 16, true);
		gibs.gravity = 500;
		gibs.setXSpeed( -80, 100);
		gibs.setYSpeed(10, 300);
		gibs.particleDrag.x = 80;
		
		gibs.bounce =0.75;
		add(gibs);
		
		
		
		map = new FlxTilemap();
		map.loadMap(Assets.getText("data/map.txt"), "images/tiles.png", 16, 16, 0, 1);
		add(map);
		
		//FlxG.camera.deadzone.set(0,0,0,0);
		
		player = new Player(60, 150);
		add(player);		
		FlxG.camera.follow(player);
		//FlxG.camera.targetOffset.set(100, 100);
		FlxG.camera.followLerp =13;
		//FlxG.camera.scroll.y -= 25;
		
		bonuses = new FlxGroup();
		add(bonuses);
		
		bricks = new FlxGroup();
		add(bricks);
		
		mushrooms = new FlxGroup();
		add(mushrooms);
		
		goombas = new FlxGroup();
		add(goombas);
		
		
		
		
		placeBoxes(Assets.getText("data/boxes.txt"));
	}
	public function hitBox(player : Player, box : Box) {
		if (box.animation.name != "used" && box.isTouching(FlxObject.FLOOR)) {
			box.hit();			
		}
	}
	public function eatShroom(player : Player, shroom : Mushroom) {
		FlxG.camera.shake();
		FlxG.camera.angle = Std.random(20) - 10;
		FlxG.camera.flash();
		//FlxSpriteUtil.flicker(player);
		
		//player.color = 0xFFFFFF;
		//background.color = 0;
		
		map.visible = false;
		glitch.visible = true;
		glitch.strength++;
		
		mushrooms.remove(shroom);
	}
	public function actorHitWall(actor : Actor, a : FlxTilemap) {
		if (actor.isTouching(FlxObject.WALL)) {
			actor.speed = -actor.speed;			
		}
	}
	public function actorHitActor(a1 : Actor, a2 : Actor) {
		a1.speed = -a1.speed;
		a2.speed = -a2.speed;
	}
	public function playerHitActor(player : Player, actor : Actor) {
		if (actor.animation.name == "die") {
		}
		else if (player.velocity.y > 0) {
			actor.die();
			player.velocity.y = -200;
		} else {
			player.die();
			scrollSpeed = 0;
		}
	}
	override public function update() {
		if (!player.isTouching(FlxObject.FLOOR)) {
			glitch.direction = VERTICAL;
		} else {
			glitch.direction = HORIZONTAL;
		}
		super.update();
		
		for (goomb in goombas) {
			if (cast(goomb, Goomba).x - player.x < 300) {
				cast(goomb, Goomba).seen = true;
			}
		}
		
		//FlxG.camera.angle += 0.1;
		
		//FlxG.camera.scroll.x += scrollSpeed;
		
		FlxG.collide(gibs, map);
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
		FlxG.collide(goombas, map);
		
		if (FlxG.keys.pressed.RIGHT) {
			FlxG.camera.scroll.x += 5;
			player.velocity.x = player.speed;
		}
		if (FlxG.keys.justPressed.RIGHT) {
			player.turnedRight = true;
		}
		if (FlxG.keys.pressed.LEFT) {
			FlxG.camera.scroll.x -= 5;
			player.velocity.x = -player.speed;
		}
		if (FlxG.keys.justPressed.LEFT) {
			player.turnedRight = false;
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
					goombas.add(new Goomba(x*16, y*16, gibs)); 
				}
			}
				
		}
	}
}