package custom;

import psychlua.LuaUtils;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

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
				default:
					return;
			}
		}
	}

	public function customStepHit(state:String, recievedStep:Int, ?songName:String)
	{
		if (state == 'PlayState')
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
					}
				default:
					return;
			}
		}
	}
}
