package com.asylum.data
{
	public class ItemInstance
	{
		public var id:String;
		public var source:Item;
		public var isInPlay:Boolean;
		public var owner:Player;
		
		public function ItemInstance(item:Item = null)
		{
			source = item;
			isInPlay = false;
		}
	}
}