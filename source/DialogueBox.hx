package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curDialogue:String = '';
	var curCharacter:String = '';
	var curExpression:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];
	
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFF000000);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'maybe-i-was-boring', 'in-love-with-egirl', 'internet-ruined', 'rifting':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('windowbox', 'shared');
				box.animation.addByPrefix('normalOpen', 'dialoginstance', 20, false);
				box.animation.addByPrefix('normal', 'dialogwindow', 0, false);
				box.antialiasing = true;
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		portraitLeft = new FlxSprite(200, 100);
		portraitLeft.frames = Paths.getSparrowAtlas('portraits/wilburExpressions', 'shared');
		/* Expressions */
		portraitLeft.animation.addByPrefix('normal', 'wilbur normal', 24, true);
		portraitLeft.animation.addByPrefix('mad', 'wilbur mad', 24, true);
		portraitLeft.animation.addByPrefix('guitar', 'wilbur guitar', 24, true);
		/* ----------- */
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		portraitLeft.flipX = false;
		portraitLeft.scale.x = 1.2;
		portraitLeft.scale.y = 1.2;
		portraitLeft.antialiasing = true;
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(800, 180);
		portraitRight.frames = Paths.getSparrowAtlas('portraits/bfExpressions', 'shared');
		/* Expressions */
		portraitRight.animation.addByPrefix('normal', 'bf normal', 24, true);
		portraitRight.animation.addByPrefix('shocked', 'bf shocked', 24, true);
		/* ----------- */
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		portraitRight.scale.x = 1.2;
		portraitRight.scale.y = 1.2;
		portraitRight.antialiasing = true;
		add(portraitRight);
		portraitRight.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 42);
		dropText.font = 'W95FA';
		dropText.color = 0x00000000;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 42);
		swagDialogue.font = 'W95FA';
		swagDialogue.color = 0x363636;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('wilburText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			FlxTween.tween(bgFade, {alpha: 0.6}, 1.0);
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY && dialogueStarted == true)
		{
			remove(dialogue);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					FlxTween.tween(this, {alpha: 0.0}, 0.5);

					new FlxTimer().start(0.6, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				FlxG.sound.play(Paths.sound('clickText'), 0.8);
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		swagDialogue.resetText(curDialogue);
		swagDialogue.start(0.04, true, false, null, function()
		{
			portraitLeft.animation.stop();
			portraitRight.animation.stop();
		});

		switch (curCharacter)
		{
			case 'wilbur':
				portraitRight.visible = false;
				
				portraitLeft.animation.play(curExpression, true);
				if (!portraitLeft.visible)
					portraitLeft.visible = true;
			case 'bf':
				portraitLeft.visible = false;
				
				portraitRight.animation.play(curExpression, true);
				if (!portraitRight.visible)
					portraitRight.visible = true;
		}
	}

	function cleanDialog():Void
	{
		var splitDialogue:Array<String> = dialogueList[0].split(":");
		curCharacter = splitDialogue[0];
		curExpression = splitDialogue[1];
		curDialogue = splitDialogue[2];

		trace(splitDialogue);
	}
}
