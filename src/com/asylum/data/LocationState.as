package com.asylum.data
{
	public class LocationState
	{
		public var id:String;
		public var isSealed:Boolean;
		public var clueNum:int;
		
		public function LocationState(locationId:String, sealed:Boolean = false, clues:int = 0)
		{
			id = locationId;
			isSealed = sealed;
			clueNum = clues;
		}
	}
}