package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class CreditsState extends FlxState
{
    var skipped:Bool = false;
    
    var modernMediaLogo:FlxSprite;
    var ito:FlxSprite;
    var effectsTm:FlxSprite;
    var deadskull:FlxSprite;
    var gedehari:FlxSprite;

    var meetTheTeam:FlxText;

    var itoInfo:FlxText;
    var effectsTmInfo:FlxText;
    var deadskullInfo:FlxText;
    var gedehariInfo:FlxText;

	var left:Array<FlxSprite> = [];
	var right:Array<FlxSprite> = [];
    
    override public function create()
    {
        super.create();

        // This is why I should just use Godot Engine.
        // Fuck it imma just recreate FnF in Godot Engine.

        modernMediaLogo = new FlxSprite(0, 26).loadGraphic(Paths.image("credits/mmlogo", "shared"));
        modernMediaLogo.screenCenter(X);
        modernMediaLogo.antialiasing = true;
        modernMediaLogo.alpha = 0;
        add(modernMediaLogo);

		ito = new FlxSprite(98, 199).loadGraphic(Paths.image("credits/ito", "shared"));
		ito.alpha = 0;
        add(ito);
        left.push(ito);

		effectsTm = new FlxSprite(98, 481).loadGraphic(Paths.image("credits/effectstm", "shared"));
		effectsTm.alpha = 0;
        add(effectsTm);
		left.push(effectsTm);

		deadskull = new FlxSprite(994, 212).loadGraphic(Paths.image("credits/deadskull", "shared"));
		deadskull.alpha = 0;
        add(deadskull);
		right.push(deadskull);

		gedehari = new FlxSprite(972, 507).loadGraphic(Paths.image("credits/gedehari", "shared"));
        gedehari.alpha = 0;
        add(gedehari);
		right.push(gedehari);

		meetTheTeam = new FlxText(0, 167, 0, "Meet the Team:", 24);
        meetTheTeam.screenCenter(X);
		meetTheTeam.alpha = 0;
        add(meetTheTeam);

		itoInfo = new FlxText(329, 295, 0, "Ito\nArtist, Writer", 24);
		itoInfo.alpha = 0;
        add(itoInfo);
        left.push(itoInfo);

		effectsTmInfo = new FlxText(329, 546, 0, "EffectsTM\nArtist, Musician, Charter", 24);
		effectsTmInfo.alpha = 0;
		add(effectsTmInfo);
		left.push(effectsTmInfo);

        deadskullInfo = new FlxText(803, 295, 0, "Deadskull\nMusician");
		deadskullInfo.setFormat(null, 24, FlxColor.WHITE, RIGHT);
		deadskullInfo.alpha = 0;
		add(deadskullInfo);
        right.push(deadskullInfo);

		gedehariInfo = new FlxText(755, 546, 0, "gedehari\nProgrammer");
		gedehariInfo.setFormat(null, 24, FlxColor.WHITE, RIGHT);
		gedehariInfo.alpha = 0;
		add(gedehariInfo);
		right.push(gedehariInfo);

        modernMediaLogo.y = 0;
        FlxTween.tween(modernMediaLogo, {y: 26, alpha: 1.0}, 1.0);

        meetTheTeam.y -= 26;
		FlxTween.tween(meetTheTeam, {y: meetTheTeam.y + 26, alpha: 1.0}, 1.0);

        for (child in left)
        {
            var origX:Float = child.x;
            child.x -= 30;
            FlxTween.tween(child, {x: origX, alpha: 1.0}, 1.0);
        }

		for (child in right)
		{
			var origX:Float = child.x;
			child.x += 30;
			FlxTween.tween(child, {x: origX, alpha: 1.0}, 1.0);
		}
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER && !skipped)
        {
			skipped = true;
            
            FlxTween.tween(modernMediaLogo, {y: modernMediaLogo.y - 26, alpha: 0.0}, 1.0);
			FlxTween.tween(meetTheTeam, {y: meetTheTeam.y - 26, alpha: 0.0}, 1.0);

			for (child in left)
			{
				FlxTween.tween(child, {x: child.x - 30, alpha: 0.0}, 1.0);
			}

			for (child in right)
			{
				FlxTween.tween(child, {x: child.x + 30, alpha: 0.0}, 1.0);
			}

            new FlxTimer().start(1.0, function(_:FlxTimer)
            {
                FlxG.switchState(new MainMenuState());
            });
        }
    }
}