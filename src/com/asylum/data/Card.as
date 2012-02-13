package com.asylum.data
{
	public class Card
	{
		public var id:int;
		public var name:String;
		public var num:int;
		private var _type:String;
		public var text:String;
		public var imageUrl:String;
		
		public function Card(type:String = null)
		{
			_type = type;
			imageUrl = "";
		}

		public function get type():String
		{
			return _type;
		}
	}
}