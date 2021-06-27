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
		bgFaded.scale.y *= 0.35;
		bgFaded.scale.y *= 0.35;
		bgFaded.screenCenter();
		bgFaded.alpha = 1;
		add(bgFaded);
		
		var wilburlogo:FlxSprite = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image('WilburSootLogo'));
		wilburlogo.scale.y = 0.3;
		wilburlogo.scale.x = 0.3;
		wilburlogo.x -= wilburlogo.frameHeight;
		wilburlogo.y -= 180;
		wilburlogo.alpha = 0.8;
		add(wilburlogo);
		
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"Hey!"
			+ "\nThe character showen and portrayed is NOT Wilbur Soot IRL!"
			+ "\nThe character portrayed is from Wilburs SONGS!"
			+ "\n(NOT INCULDING EPS LIKE, YOUR CITY GAVE ME ASTHMA AND MAYBE I WAS BORING.)",
			32);
		
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);
		
		FlxTween.angle(wilburlogo, wilburlogo.angle, -10, 2, {ease: FlxEase.quartInOut});
	
		
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			if(wilburlogo.angle == -10) FlxTween.angle(wilburlogo, wilburlogo.angle, 10, 2, {ease: FlxEase.quartInOut});
			else FlxTween.angle(wilburlogo, wilburlogo.angle, -10, 2, {ease: FlxEase.quartInOut});
		}, 0);
		
		new FlxTimer().start(0.8, function(tmr:FlxTimer)
		{
			if(wilburlogo.alpha == 0.8) FlxTween.tween(wilburlogo, {alpha: 1}, 0.8, {ease: FlxEase.quartInOut});
			else FlxTween.tween(wilburlogo, {alpha: 0.8}, 0.8, {ease: FlxEase.quartInOut});
		}, 0);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		if (controls.BACK)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
