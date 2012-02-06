package com.asylum.data
{
	import com.asylum.view.map.ILocation;
	
	public class MonsterInstance implements IMiniature, ITrophy
	{
		public var id:String;
		public var source:Monster;
		private var _location:ILocation;
		private var _isTrophy:Boolean;
		private var _claimant:Player;
		
		public function MonsterInstance(monster:Monster)
		{
			this.source = monster;
			_isTrophy = false;
		}
		
		public function get label():String
		{
			return source.name;
		}
		
		public function get imageUrl():String
		{
			return source.imageUrl;
		}
		
		public function get location():ILocation
		{
			return _location;
		}
		
		public function set location(value:ILocation):void
		{
			_location = value;
		}

		public function get isTrophy():Boolean
		{
			return _isTrophy;
		}

		public function set isTrophy(value:Boolean):void
		{
			_isTrophy = value;
		}

		public function get claimant():Player
		{
			return _claimant;
		}

		public function set claimant(value:Player):void
		{
			_claimant = value;
		}
	}
}