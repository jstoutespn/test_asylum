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
		public var isCurrentTurn:Boolean;
		public var order:int;
		public var characterId:int;
		public var character:Character;
		private var _locationId:String;
		private var _location:ILocation;
		public var inventory:Vector.<CardInstance>;
		public var trophies:Vector.<ITrophy>;
		
		public function Player()
		{
			characterId = -1;
			order = -1;
			isMe = false;
			isFirstPlayer = false;
			isCurrentTurn = false;
			_locationId = "";
			inventory = new Vector.<CardInstance>();
			trophies = new Vector.<ITrophy>();
		}
				
		public function get label():String 
		{
			return firstName;
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

		public function get locationId():String
		{
			return _locationId;
		}

		public function set locationId(value:String):void
		{
			_locationId = value;
		}

	}
}