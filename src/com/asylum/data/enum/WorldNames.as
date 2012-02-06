package com.asylum.data.enum
{
	public class WorldNames
	{
		public static function getOtherworldName(id:String):String {
			switch (id) {
				case Locations.RLEYH:
					return "R'Lyeh";
					break;
				case Locations.LENG:
					return "Plateau of Leng";
					break;
				case Locations.DREAMLANDS:
					return "The Dreamlands";
					break;
				case Locations.CELEANO:
					return "Great Hall of Celeano";
					break;
				case Locations.YUGGOTH:
					return "Yuggoth";
					break;
				case Locations.CITY:
					return "City of the Great Race";
					break;
				case Locations.ABYSS:
					return "Abyss";
					break;
				case Locations.ANOTHERDIM:
					return "Another Dimension";
					break;
			}
			return null;
		}
	}
}