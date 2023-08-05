function goodNoteHit(n):Void
{
	for (i in game.members)
		if (i != null && Std.isOfType(i, FlxSprite) && i.exists && i.acceleration.y != 0)
		{
			i.cameras = [game.camGame];
			if (i.origin.x != 1.0001)
			{
				i.origin.set(1.0001, 1);
				i.x += 300;
			}
		}
}
