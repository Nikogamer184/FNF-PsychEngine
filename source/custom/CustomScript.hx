package custom;

import psychlua.LuaUtils;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class CustomScript
{
	var game:PlayState;

	public function new()
	{
		game = PlayState.instance;
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
					game.camGame.flash(0xFF000000, 10, null, false);
					game.skipCountdown = true;
					game.cameraSpeed = 10;
					game.camHUD.alpha = 0;
					game.dadGroup.alpha = 0.0001;
					game.gfGroup.alpha = 0.0001;

					var loading:FlxSprite = new FlxSprite(1150, 880).loadGraphic(Paths.image('backgrounds/flanima/loading'));
					var noway:FlxSprite = new FlxSprite(-600, -300).makeGraphic(2600, 1600, 0xFFCBFD56);
					addSpriteToStage(noway);
					game.add(loading);
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
					}
				default:
					return;
			}
		}
	}
}
