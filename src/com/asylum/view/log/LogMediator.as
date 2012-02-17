package com.asylum.view.log
{
	import com.asylum.data.Log;
	import com.asylum.data.enum.NoteName;
	import com.asylum.mediator.BaseMediator;
	
	import flash.events.Event;
	
	import flashx.textLayout.elements.TextFlow;
	
	import mx.collections.ArrayCollection;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	import spark.formatters.DateTimeFormatter;
	import spark.utils.TextFlowUtil;
	
	public class LogMediator extends BaseMediator
	{
		public static const NAME:String = "logMediator";
		
		private var logs:ArrayCollection;
		private var logSort:Sort;
		private var timeFormatter:DateTimeFormatter;
		private var _lastTimestamp:Date;
		
		public function LogMediator(viewComponent:GameLog)
		{
			logs = new ArrayCollection();
			// set up sort
			logSort = new Sort();
			var dateField:SortField = new SortField("time", false);
			var idField:SortField = new SortField("id", true);
			logSort.fields = [dateField, idField];
			logSort.unique = true;
			logs.sort = logSort;
			// set up lastTimestamp
			_lastTimestamp = new Date();
			_lastTimestamp.setTime(0);
			// set up datetime formatting
			timeFormatter = new DateTimeFormatter();
			timeFormatter.dateTimePattern = "M-d-yyyy HH:mm:ss";
			super(NAME, viewComponent);
			// set up event listeners
			view.addEventListener(GameLog.CHAT, onChat, false, 0, true);
		}
				
		private function get view():GameLog {
			return viewComponent as GameLog;
		}
		
		public function get lastTimestamp():Date
		{
			return _lastTimestamp;
		}

		public function hasLog(id:String):Boolean {
			var loglen:int = logs.length;
			var currLog:Log;
			for (var i:int = 0; i<loglen; i++) {
				currLog = logs.getItemAt(i) as Log;
				if (currLog.id == id) {
					return true;
				}
			}
			return false;
		}
		
		public function addLog(log:Log, renderNow:Boolean = false, ignoreTimestamp:Boolean = false):void {
			if ( !hasLog(log.id) ) {
				logs.addItem(log);
				if ( log.time.getTime() > _lastTimestamp.getTime() && !ignoreTimestamp ) {
					_lastTimestamp.setTime(log.time.getTime());
				}
				if (!log.isRendered && renderNow) {
					renderLog(log);
				}
			}
		}
		
		public function getLog(id:String):Log {
			var loglen:int = logs.length;
			var log:Log;
			for (var i:int = 0; i<loglen; i++) {
				log = logs.getItemAt(i) as Log;
				if (log.id == id) {
					return log;
				}
			}
			return null;
		}
		
		public function update():void {
			logs.refresh();
			var unrendered:Vector.<Log> = getUnrenderedLogs();
			if (unrendered.length > 0) {
				for each (var curr:Log in unrendered) {
					renderLog(curr);
				}
			}
		}
		
		public function refresh():void {
			logs.refresh();
			var loglen:int = logs.length;
			var log:Log;
			var batch:String = new String();
			var curr:String;
			for (var i:int = 0; i<loglen; i++) {
				log = logs.getItemAt(i) as Log;
				curr = batchRenderLog(log);
				batch += curr;
			}
			view.logField.textFlow = TextFlowUtil.importFromString(batch);
		}
		
		public function updateLogId(oldId:String, newId:String):void {
			var log:Log = getLog(oldId);
			if (log != null) {
				log.id = newId;
			}
		}
		
		private function onChat(event:Event):void
		{
			var chatMsg:String = view.getChat();
			view.clearChat();
			sendNotification(NoteName.SEND_CHAT, {chat:chatMsg, logMediator:this});
		}
		
		private function renderLog(log:Log):void {
			var markup:String = getLogMarkup(log);
			var logFlow:TextFlow = TextFlowUtil.importFromString(markup);
			view.logField.textFlow.addChild(logFlow.getChildAt(0));
			log.isRendered = true;
		}
		
		private function batchRenderLog(log:Log):String {
			var markup:String = getLogMarkup(log);
			log.isRendered = true;
			return markup;
		}
		
		private function getUnrenderedLogs():Vector.<Log> {
			var list:Vector.<Log> = new Vector.<Log>();
			var loglen:int = logs.length;
			var curr:Log;
			for (var i:int = 0; i<loglen; i++) {
				curr = logs.getItemAt(i) as Log;
				if (!curr.isRendered) {
					list.push(curr);
				}
			}
			return list;
		}
		
		private function getLogMarkup(log:Log):String {
			var markup:String;
			if (log.isChat) {
				markup = '<p id="' + log.id + '"><span fontWeight="bold">' + log.player.name + '</span> [' + timeFormatter.format(log.time) + ']: ' + log.text + '</p>';
			} else {
				markup = '<p id="' + log.id + '"><span color="#333333">' + log.player.name + ' ' + log.text + '</span></p>';
			}
			return markup;
		}


		
	}
}