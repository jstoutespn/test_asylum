package com.asylum.factory
{
	import com.asylum.data.LocationState;

	public class MapFactory
	{
		public static function makeLocationState(xml:XML):LocationState {
			var locId:String = xml.@id;
			var locationState:LocationState = new LocationState(locId);
			locationState.clueNum = parseFloat(xml.@clues) as int;
			if (xml.hasOwnProperty("@closed") && xml.@closed == "true") {
				locationState.isClosed = true;
			}
			if (xml.hasOwnProperty("@sealed") && xml.@sealed == "true") {
				locationState.isSealed = true;
			}
			return locationState;
		}
		
		public static function getLocationStateXML(locationState:LocationState):XML {
			var xml:XML = new XML("<location></location>");
			xml.@id = locationState.id;
			xml.@clues = locationState.clueNum;
			if (locationState.isClosed) {
				xml.@closed = "true";
			} else {
				xml.@closed = "false";
			}
			if (locationState.isSealed) {
				xml.@sealed = "true";
			} else {
				xml.@sealed = "false";
			}
			return xml;
		}
	}
}