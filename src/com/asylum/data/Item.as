package com.asylum.data
{
	public class Item extends Card
	{
		public var subType:String;
		public var hands:int;
		public var price:int;
		
		public function Item(type:String = null)
		{
			hands = 0;
			price = 0;
			subType = "";
			super(type);
		}
	}
}