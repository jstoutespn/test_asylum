package com.asylum.model
{
	import com.asylum.data.AncientOne;
	import com.asylum.data.Character;
	import com.asylum.data.Gate;
	import com.asylum.data.Item;
	import com.asylum.data.Monster;
	import com.asylum.data.Skill;
	import com.asylum.data.Spell;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class SourceProxy extends Proxy
	{
		public static const NAME:String = "srcProxy";
		
		public var monsters:Vector.<Monster>;
		public var characters:Vector.<Character>;
		public var gates:Vector.<Gate>;
		public var commonItems:Vector.<Item>;
		public var uniqueItems:Vector.<Item>;
		public var spells:Vector.<Spell>;
		public var skills:Vector.<Skill>;
		public var ancients:Vector.<AncientOne>;
		
		public function SourceProxy()
		{
			monsters = new Vector.<Monster>();
			characters = new Vector.<Character>();
			gates = new Vector.<Gate>();
			commonItems = new Vector.<Item>();
			uniqueItems = new Vector.<Item>();
			spells = new Vector.<Spell>();
			skills = new Vector.<Skill>();
			ancients = new Vector.<AncientOne>();
			super(NAME, null);
		}
		
		public function getItem(id:int):Item {
			var comlen:int = commonItems.length;
			var unilen:int = uniqueItems.length;
			var slen:int = spells.length;
			var item:Item;
			for (var c:int = 0; c<comlen; c++) {
				item = commonItems[c];
				if (item.id == id) {
					return item;
				}
			}
			for (var u:int = 0; u<unilen; u++) {
				item = uniqueItems[u];
				if (item.id == id) {
					return item;
				}
			}
			for (var s:int = 0; s<slen; s++) {
				item = spells[s] as Item;
				if (item.id == id) {
					return item;
				}
			}
			return null;
		}
	}
}