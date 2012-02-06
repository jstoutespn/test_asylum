package com.asylum.data
{
	public class Config
	{
		private static var instance:Config;
		
		private var _userId:String;
		private var _accessToken:String;
		private var _configURL:String;
		
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
			_userId = parameters['user'];
			_accessToken = parameters['token'];
			_configURL = parameters['configURL'];
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

	}
} class SingletonEnforcer {}