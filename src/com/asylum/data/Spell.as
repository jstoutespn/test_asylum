package com.asylum.data
{
	public class Spell extends Card
	{
		public var hands:int;
		public var castmod:int;
		public var sancost:int;
		
		public function Spell()
		{
			hands = 0;
			super("spell");
		}
	}
}