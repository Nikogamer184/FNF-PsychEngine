package custom;

import psychlua.LuaUtils;

class CustomScript
{
	public static function customCreate(state:String, ?songName:String)
	{
		if (state == 'PlayState')
		{
			var game:PlayState = PlayState.instance;

			function addSpriteToStage(sprite:FlxSprite)
			{
				game.insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), sprite);
			}

			switch (songName)
			{
				case 'SET ME FREE':
					var loading:FlxSprite = new FlxSprite(1150, 880).loadGraphic(Paths.image('backgrounds/flanima/loading'));
					var noway:FlxSprite = new FlxSprite(-600, -300).makeGraphic(2600, 1600, 0xFFCBFD56);
					addSpriteToStage(noway);
					game.add(loading);
				default:
					return;
			}
		}
	}
}
