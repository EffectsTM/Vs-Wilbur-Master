package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class WarningSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";
	
	private var bgColors:Array<String> = [
		'#314d7f',
		'#4e7093',
		'#70526e',
		'#594465'
	];
	private var colorRotation:Int = 1;

	override function create()
	{
		super.create();
		var bgFaded:FlxSprite = new FlxSprite().loadGraphic(Paths.image('fadedbackground'));
		bgFaded.setGraphicSize(1280, 720);
		bgFaded.updateHitbox();
		bgFaded.origin.set();
		add(bgFaded);
		
		var wilburlogo:FlxSprite = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image('WilburSootLogo'));
		wilburlogo.scale.x = 0.5;
		wilburlogo.scale.y = 0.5;
		wilburlogo.screenCenter(X);
		wilburlogo.y = -70;
		add(wilburlogo);
		
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"Hey!"
			+ "\nThe character shown and portrayed is NOT Wilbur Soot IRL!"
			+ "\nThe character portrayed is from Wilbur's SONGS!"
			+ "\n(NOT INCULDING EPS LIKE \"Your City Gave Me Asthma\" AND \"Maybe I Was Boring\".)"
			+ "\nPress ENTER key to continue",
			32);
		
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter(X);
		txt.y = 390;
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		
		super.update(elapsed);
	}
}
