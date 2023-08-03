package custom;

class CustomScript
{
	public var Game = PlayState.instance;

	public static function customCreate(state:String, ?songName:String)
	{
		if(state == 'PlayState')
		{
			switch (songName)
			{
				case '':
					//Placeholder
				default:
					return;
			}

		}

	}
	
}