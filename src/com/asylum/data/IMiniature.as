package com.asylum.data
{
	import com.asylum.view.map.ILocation;

	public interface IMiniature
	{
		function get label():String;
		function get imageUrl():String;
		function get location():ILocation;
		function set location(value:ILocation):void;
	}
}