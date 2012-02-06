package com.asylum.data
{
	public class Monster
	{
		public var id:int;
		public var name:String;
		public var number:int;
		public var symbol:String;
		public var movement:int;
		public var awareness:int;
		public var combat:int;
		public var damage:int;
		public var horror:int;
		public var sanDamage:int;
		public var toughness:int;
		public var abilities:Vector.<MonsterAbility>;
		public var imageUrl:String;
		
		public function Monster()
		{
			abilities = new Vector.<MonsterAbility>();
		}
	}
}