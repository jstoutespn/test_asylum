package com.asylum.data
{
	public class Character
	{
		public var id:int;
		public var name:String;
		public var sanity:int;
		public var maxSanity:int;
		public var stamina:int;
		public var maxStamina:int;
		public var focus:int;
		public var uniqueTitle:String;
		public var uniqueText:String;
		
		public var speed:Stat;
		public var sneak:Stat;
		public var fight:Stat;
		public var will:Stat;
		public var lore:Stat;
		public var luck:Stat;
		
		public var cash:int;
		public var clues:int;
		
		public var randomDraw:RandomItemDraw;
		
		public var blessed:Boolean;
		public var cursed:Boolean;
				
		public function Character()
		{
			blessed = false;
			cursed = false;
		}
	}
}