package com.asylum.data
{
	import com.asylum.view.map.ILocation;

	public class GateInstance implements ITrophy
	{
		public var id:String;
		public var source:Gate;
		public var location:ILocation;
		private var _isTrophy:Boolean;
		private var _claimant:Player;
		
		public function GateInstance(gate:Gate)
		{
			source = gate;
			_isTrophy = false;
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