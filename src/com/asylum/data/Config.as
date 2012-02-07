package com.asylum.data
{
	public class Config
	{
		private static var instance:Config;
		
		private var _gameId:int;
		private var _userId:String;
		private var _accessToken:String;
		private var _configURL:String;
		private var _gameURL:String;
		private var _cardsURL:String;
		private var _charactersURL:String;
		
		public static function getInstance():Config
		{
			if (instance == null) {
				instance = new Config(new SingletonEnforcer());
			}
			return instance;
		}
		
		public static function get i():Config {
			return getInstance();
		}
		
		public function Config(enforcer:SingletonEnforcer)
		{
		}
		
		public function getParameters(parameters:Object):void {
			_gameId = parseFloat(parameters['game']) as int;
			_userId = parameters['user'];
			_accessToken = parameters['token'];
			_configURL = parameters['config'];
		}
		
		public function getConfig(xml:XML):void {
			_cardsURL = xml..cardUrl;
			_charactersURL = xml..charUrl;
		}

		public function get userId():String
		{
			return _userId;
		}

		public function get accessToken():String
		{
			return _accessToken;
		}

		public function get configURL():String
		{
			return _configURL;
		}

		public function get gameURL():String
		{
			return _gameURL;
		}

		public function get cardsURL():String
		{
			return _cardsURL;
		}

		public function get charactersURL():String
		{
			return _charactersURL;
		}


	}
} class SingletonEnforcer {}