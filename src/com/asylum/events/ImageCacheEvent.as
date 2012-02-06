package com.asylum.events
{
	import flash.events.Event;
	
	public class ImageCacheEvent extends Event
	{
		public static const URL_READY:String = "imgCacheUrlReady";
		public static const URL_FAILED:String = "imgCacheUrlFailed";
		
		private var _url:String;
		
		public function ImageCacheEvent(type:String, url:String = null)
		{
			_url = url;
			super(type, false, false);
		}

		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}

	}
}