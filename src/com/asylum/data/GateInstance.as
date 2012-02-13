package com.asylum.data
{
	import com.asylum.view.map.ILocation;

	public class GateInstance implements ITrophy
	{
		public var id:String;
		public var source:Gate;
		private var _locationId:String;
		private var _location:ILocation;
		private var _isTrophy:Boolean;
		private var _claimant:Player;
		
		public function GateInstance(gate:Gate = null)
		{
			source = gate;
			_isTrophy = false;
			locationId = "";
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

		public function get locationId():String
		{
			return _locationId;
		}

		public function set locationId(value:String):void
		{
			_locationId = value;
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