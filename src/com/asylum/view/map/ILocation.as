package com.asylum.view.map
{
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;

	public interface ILocation extends IEventDispatcher
	{
		function get mapId():String;
		function get mapName():String;
		function get characters():ArrayCollection;
		function get monsters():ArrayCollection;
	}
}