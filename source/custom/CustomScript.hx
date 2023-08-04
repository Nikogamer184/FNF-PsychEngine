package custom;

import psychlua.LuaUtils;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import backend.ClientPrefs;

class CustomScript
{
	var game:PlayState;

	var localSprites:Array<Dynamic>;

	public function new()
	{
		game = PlayState.instance;
		localSprites = [];
	}

	function addSpriteToStage(sprite:FlxSprite) // addLuaSprite()
	{
		game.insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), sprite);
	}

	public function customCreate(state:String, ?songName:String)
	{
		if (state == 'PlayState')
		{
			switch (songName)
			{
				case 'SET ME FREE':
					game.skipCountdown = true;
				default:
					return;
			}
		}
	}

	public function customCreatePost(state:String, ?songName:String)
	{
		if (state == 'PlayState')
		{
			switch (songName)
			{
				case 'SET ME FREE':
					game.camGame.flash(0xFF000000, 10, null, false);
					game.cameraSpeed = 10;
					game.camHUD.alpha = 0;
					game.dadGroup.alpha = 0.0001;
					game.gfGroup.alpha = 0.0001;
					game.iconP2.alpha = 0.0001;

					localSprites[0] = new FlxSprite(1150, 880).loadGraphic(Paths.image('backgrounds/flanima/loading'));
					localSprites[1] = new FlxSprite(-600, -300).makeGraphic(2600, 1600, 0xFFCBFD56);

					addSpriteToStage(localSprites[1]);
					game.add(localSprites[0]);

					localSprites[3] = new FlxSprite(-600, -300).loadGraphic(Paths.image('backgrounds/flanima/wall'));
					localSprites[4] = new FlxSprite(-780, -250).loadGraphic(Paths.image('backgrounds/flanima/floor'));
					localSprites[5] = new FlxSprite(-625, -150).loadGraphic(Paths.image('backgrounds/flanima/spotlights'));
					localSprites[6] = new FlxSprite(-500, -200).loadGraphic(Paths.image('backgrounds/flanima/curtains'));

					localSprites[4].scale.set(1.1, 1.1);
					localSprites[6].scrollFactor.set(1.3, 1.3);
					localSprites[6].scale.set(0.9, 0.9);
				default:
					return;
			}
		}
	}

	public function customStepHit(recievedStep:Int, songName:String)
	{
		switch (songName)
		{
			case 'SET ME FREE':
				switch (recievedStep)
				{
					case 112:
						game.modchartTweens.set('appear', FlxTween.tween(game.camHUD, {alpha: 1}, 1, {
							onComplete: function(twn:FlxTween)
							{
								game.modchartTweens.remove('appear');
							}
						}));
					case 192:
						game.modchartTweens.set('oh?', FlxTween.tween(game.camGame, {zoom: 1.25}, 5, {
							ease: FlxEase.sineInOut,
							onComplete: function(twn:FlxTween)
							{
								game.modchartTweens.remove('oh?');
							}
						}));
						game.modchartTweens.set('loadingfade', FlxTween.tween(localSprites[0], {alpha: 0}, 4, {
							onComplete: function(twn:FlxTween)
							{
								game.modchartTweens.remove('loadingfade');
								localSprites[0].destroy;
							}
						}));
					case 248:
						game.cameraSpeed = 5;
						game.defaultCamZoom = 1.1;
						game.dadGroup.alpha = 1;
						game.iconP2.alpha = 1;

						game.boyfriendCameraOffset[0] = -50;
						game.boyfriendCameraOffset[1] = 0;
					case 256:
						game.defaultCamZoom = 1;
					case 384:
						game.camGame.flash(0xFFFFFFFF, 0.4, null, false);
						game.cameraSpeed = 2;
						game.defaultCamZoom = 0.95;
						game.gfGroup.alpha = 1;

						localSprites[1].destroy;

						addSpriteToStage(localSprites[3]);
						addSpriteToStage(localSprites[4]);

						if (!ClientPrefs.data.lowQuality)
						{
							game.add(localSprites[5]);
							game.add(localSprites[6]);
						}
					default:
						return;
				}
		}
	}
}
