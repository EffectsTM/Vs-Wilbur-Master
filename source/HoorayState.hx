package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.transition.FlxTransitionableState;

class HoorayState extends FlxTransitionableState
{
    var logoBl:FlxSprite;
    var faded:FlxSprite;
    var congratsText:FlxText;
    var goToFreeplayText:FlxText;
    var dreamsmp:FlxText;
    
    override public function create()
    {
        super.create();

		faded = new FlxSprite(0, -160);
		faded.frames = Paths.getSparrowAtlas('endscreenlol');
		faded.antialiasing = true;
		faded.animation.addByPrefix('impostor', 'background', 24);
		faded.animation.play('impostor');
		faded.updateHitbox();
        faded.screenCenter(X);
		faded.scale.x = 0.7;
		faded.scale.y = 0.7;
        add(faded);
		
		logoBl = new FlxSprite(0, -80);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 12);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
        logoBl.screenCenter(X);
        add(logoBl);

        congratsText = new FlxText(0, 400, 0, "Congrats!\nYou beat the mod!\nWe have put so much effort in this mod\nSo we really hope you enjoyed!\nSee you next time! - Team Modern Media", 19);
        congratsText.setFormat(null, 32, FlxColor.WHITE, FlxTextAlign.CENTER);
        congratsText.updateHitbox();
        congratsText.screenCenter(X);
        add(congratsText);
        
		goToFreeplayText = new FlxText(0, 630, 0, "We made one more song for you! go to freeplay to play it!.", 19);
        goToFreeplayText.screenCenter(X);
		add(goToFreeplayText);
		
		dreamsmp = new FlxText(0, 670, 0, "If you dont like DSMP (I understand), I would suggest not play this one :)", 18);
        dreamsmp.screenCenter(X);
		add(dreamsmp);
    }

    override public function update(elapsed:Float)
    {
		super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new MainMenuState());
        }
    }
}