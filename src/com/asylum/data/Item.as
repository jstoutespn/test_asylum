package com.asylum.data
{
	public class Item
	{
		public var id:int;
		public var name:String;
		public var num:int;
		public var type:String;
		public var subType:String;
		public var hands:int;
		public var price:int;
		public var text:String;
		
		public function Item()
		{
			hands = 0;
			price = 0;
			subType = "";
		}
	}
}