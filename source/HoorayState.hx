package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HoorayState extends FlxState
{
    var logoBl:FlxSprite;
    var congratsText:FlxText;
    var goToFreeplayText:FlxText;
    
    override public function create()
    {
        super.create();

		logoBl = new FlxSprite(0, -20);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
        logoBl.screenCenter(X);
        add(logoBl);

        congratsText = new FlxText(0, 500, 0, "Congrats!\nYou beat the mod!");
        congratsText.setFormat(null, 32, FlxColor.WHITE, FlxTextAlign.CENTER);
        congratsText.updateHitbox();
        congratsText.screenCenter(X);
        add(congratsText);
        
		goToFreeplayText = new FlxText(0, 650, 0, "now go to freeplay...", 16);
        goToFreeplayText.screenCenter(X);
		add(goToFreeplayText);
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