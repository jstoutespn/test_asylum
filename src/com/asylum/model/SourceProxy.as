package com.asylum.model
{
	import com.asylum.data.Ally;
	import com.asylum.data.AncientOne;
	import com.asylum.data.Card;
	import com.asylum.data.Character;
	import com.asylum.data.Gate;
	import com.asylum.data.Item;
	import com.asylum.data.Monster;
	import com.asylum.data.MonsterAbility;
	import com.asylum.data.Skill;
	import com.asylum.data.Special;
	import com.asylum.data.Spell;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class SourceProxy extends Proxy
	{
		public static const NAME:String = "srcProxy";
		
		public var monsters:Vector.<Monster>;
		public var monsterAbilities:Vector.<MonsterAbility>;
		public var characters:Vector.<Character>;
		public var gates:Vector.<Gate>;
		public var commonItems:Vector.<Item>;
		public var uniqueItems:Vector.<Item>;
		public var spells:Vector.<Spell>;
		public var skills:Vector.<Skill>;
		public var specials:Vector.<Special>;
		public var allies:Vector.<Ally>;
		public var ancients:Vector.<AncientOne>;
		
		public function SourceProxy()
		{
			monsters = new Vector.<Monster>();
			monsterAbilities = new Vector.<MonsterAbility>();
			characters = new Vector.<Character>();
			gates = new Vector.<Gate>();
			commonItems = new Vector.<Item>();
			uniqueItems = new Vector.<Item>();
			spells = new Vector.<Spell>();
			skills = new Vector.<Skill>();
			specials = new Vector.<Special>();
			allies = new Vector.<Ally>();
			ancients = new Vector.<AncientOne>();
			super(NAME, null);
		}
		
		public function getCharacter(id:int):Character {
			for each (var char:Character in characters) {
				if (char.id == id) {
					return char;
				}
			}
			return null;
		}
		
		public function getAncientOne(id:int):AncientOne {
			for each (var ancient:AncientOne in ancients) {
				if (ancient.id == id) {
					return ancient;
				}
			}
			return null;
		}
		
		public function getMonster(id:int):Monster {
			for each (var monster:Monster in monsters) {
				if (monster.id == id) {
					return monster;
				}
			}
			return null;
		}
		
		public function getMonsterAbility(id:String):MonsterAbility {
			for each (var abil:MonsterAbility in monsterAbilities) {
				if (abil.id == id) {
					return abil;
				}
			}
			return null;
		}
		
		public function getGate(id:int):Gate {
			for each (var gate:Gate in gates) {
				if (gate.id == id) {
					return gate;
				}
			}
			return null;
		}
		
		public function getCard(id:int):Card {
			for each (var common:Item in commonItems) {
				if (common.id == id) {
					return common;
				}
			}
			for each (var unique:Item in uniqueItems) {
				if (unique.id == id) {
					return unique;
				}
			}
			for each (var spell:Spell in spells) {
				if (spell.id == id) {
					return spell;
				}
			}
			for each (var skill:Skill in skills) {
				if (skill.id == id) {
					return skill;
				}
			}
			for each (var special:Special in specials) {
				if (special.id == id) {
					return special;
				}
			}
			for each (var ally:Ally in allies) {
				if (ally.id == id) {
					return ally;
				}
			}
			return null;
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