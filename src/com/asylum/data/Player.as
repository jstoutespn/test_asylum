package com.asylum.data
{
	import com.asylum.view.map.ILocation;

	public class Player implements IMiniature
	{
		public var id:String;
		public var name:String;
		public var firstName:String;
		public var lastName:String;
		private var _imageUrl:String;
		public var isMe:Boolean;
		public var isFirstPlayer:Boolean;
		public var characterId:int;
		public var character:Character;
		private var _location:ILocation;
		public var trophies:Vector.<ITrophy>;
		public var inventory:Vector.<ItemInstance>;
		
		public function Player()
		{
			characterId = -1;
			isMe = false;
			isFirstPlayer = false;
		}
		
		public function get label():String 
		{
			return name;
		}
		
		public function get imageUrl():String
		{
			return _imageUrl;
		}

		public function set imageUrl(value:String):void
		{
			_imageUrl = value;
		}
		
		public function get location():ILocation
		{
			return _location;
		}
		
		public function set location(value:ILocation):void
		{
			_location = value;
		}
		
	}
}