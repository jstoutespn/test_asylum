package com.asylum.cache
{
	import com.asylum.events.ImageCacheEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class ImageCache extends EventDispatcher
	{
		private static var instance:ImageCache;
		
		private var images:Dictionary;
		private var loaders:Dictionary;
		private var blacklist:Vector.<String>;
		
		public static function getInstance():ImageCache
		{
			if (instance == null) {
				instance = new ImageCache(new SingletonEnforcer());
			}
			return instance;
		}
		
		public static function get instance():ImageCache
		{
			return getInstance();
		}
		
		public function ImageCache(enforcer:SingletonEnforcer, target:IEventDispatcher=null)
		{
			images = new Dictionary();
			loaders = new Dictionary();
			blacklist = new Vector.<String>();
			super(target);
		}
		
		public function hasUrl(url:String):Boolean
		{
			if (images[url] != null) {
				return true;
			}
			return false;
		}
		
		public function getUrl(url:String):Bitmap 
		{
			if (images[url] != null) {
				return cloneImage(images[url] as Bitmap);
			}
			return null;
		}
		
		public function requestUrl(url:String):void 
		{
			if (loaders[url] == null && !checkBlacklist(url)) {
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageError);
				loaders[url] = loader;
				loader.load(new URLRequest(url));
			}
		}
		
		public function addListeners(onLoad:Function, onFail:Function = null):void {
			addEventListener(ImageCacheEvent.URL_READY, onLoad, false, 0, true);
			if (onFail != null) {
				addEventListener(ImageCacheEvent.URL_FAILED, onFail, false, 0, true);
			}
		}
		
		public function removeListeners(onLoad:Function, onFail:Function = null) {
			removeEventListener(ImageCacheEvent.URL_READY, onLoad);
			if (onFail != null) {
				removeEventListener(ImageCacheEvent.URL_FAILED, onFail);
			}
		}
		
		private function onImageComplete(event:Event):void
		{
			// get loader and url
			var loader:Loader = event.target.loader;
			var url:String = loader.contentLoaderInfo.url;
			if (loaders[url] == null || loader.contentLoaderInfo.isURLInaccessible) {
				url = getUrlFromLoader(loader);
			}
			// remove event listeners
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageError);
			// save image
			var content:Bitmap = Bitmap(loader.content);
			var saveImage:Bitmap = cloneImage(content);
			images[url] = saveImage;
			// remove loader
			loaders[url] = null;
			// dispatch event
			dispatchEvent(new ImageCacheEvent(ImageCacheEvent.URL_READY, url));
		}

		
		private function onImageError(event:IOErrorEvent):void
		{
			// get loader and url
			var loader:Loader = event.target.loader;
			var url:String = loader.contentLoaderInfo.url;
			if (loaders[url] == null || loader.contentLoaderInfo.isURLInaccessible) {
				url = getUrlFromLoader(loader);
			}
			// remove event listeners
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageError);
			// add URL to blacklist
			blacklist.push(url);
			// send out log
			trace("== IMAGECACHE: FAILED TO LOAD " + url);
			trace("=== ERROR DETAILS: [" + event.errorID + "] " + event.text);
			// remove loader
			loaders[url] = null;
			// dispatch event
			dispatchEvent(new ImageCacheEvent(ImageCacheEvent.URL_FAILED, url));
		}
		
		private function cloneImage(bitmap:Bitmap):Bitmap {
			var dataClone:BitmapData = bitmap.bitmapData.clone();
			var clone:Bitmap = new Bitmap(dataClone);
			return clone;
		}
		
		private function getUrlFromLoader(loader:Loader):String {
			var temp:Loader;
			for (var key:String in loaders) {
				temp = loaders[key];
				if (temp === loader) {
					return key;
				}
			}
			return null;
		}
		
		private function checkBlacklist(url:String):Boolean {
			var len:int = blacklist.length;
			var temp:String;
			for (var u:int = 0; u<len; u++) {
				temp = blacklist[u];
				if (temp == url) {
					return true;
				}
			}
			return false;
		}
	}
} class SingletonEnforcer {}