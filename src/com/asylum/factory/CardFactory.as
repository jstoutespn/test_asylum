package com.asylum.factory
{
	import com.asylum.data.Ally;
	import com.asylum.data.CardInstance;
	import com.asylum.data.Config;
	import com.asylum.data.Gate;
	import com.asylum.data.GateInstance;
	import com.asylum.data.Item;
	import com.asylum.data.Skill;
	import com.asylum.data.Special;
	import com.asylum.data.Spell;

	public class CardFactory
	{
		public static function makeGate(xml:XML):Gate {
			var gate:Gate = new Gate();
			gate.id = parseFloat(xml.@id) as int;
			gate.world = xml.@world;
			gate.symbol = xml.@symbol;
			gate.modifier = parseFloat(xml.@modifier) as int;
			gate.num = parseFloat(xml.@num) as int;
			return gate;
		}
		
		public static function makeItem(xml:XML):Item {
			var itemType:String = xml.@type;
			var item:Item = new Item(itemType);
			item.id = parseFloat(xml.@id);
			item.num = parseFloat(xml.@num) as int;
			item.name = xml..name;
			if (xml.child("image").length() > 0) {
				item.imageUrl = xml..image;
			}
			if (xml.child("subtype").length() > 0) {
				item.subType = xml..subtype;
			}
			if (xml.child("hands").length() > 0) {
				item.hands = parseFloat(xml..hands) as int;
			}
			if (xml.child("price").length() > 0) {
				item.price = parseFloat(xml..price) as int;
			}
			item.text = xml..text;
			return item;
		}
		
		public static function makeSpell(xml:XML):Spell {
			var spell:Spell = new Spell();
			spell.id = parseFloat(xml.@id);
			spell.num = parseFloat(xml.@num) as int;
			spell.name = xml..name;
			if (xml.child("image").length() > 0) {
				spell.imageUrl = xml..image;
			}
			if (xml.child("hands").length() > 0) {
				spell.hands = parseFloat(xml..hands) as int;
			}
			spell.text = xml..text;
			spell.castmod = parseFloat(xml.@modifier) as int;
			spell.sancost = parseFloat(xml.@cost) as int;
			return spell;
		}
		
		public static function makeSkill(xml:XML):Skill {
			var skill:Skill = new Skill();
			skill.id = parseFloat(xml.@id) as int;
			skill.num = parseFloat(xml.@num) as int;
			skill.name = xml..name;
			skill.text = xml..text;
			return skill;
		}
		
		public static function makeSpecial(xml:XML):Special {
			var special:Special = new Special();
			special.id = parseFloat(xml.@id) as int;
			special.num = parseFloat(xml.@num) as int;
			special.name = xml..name;
			special.text = xml..text;
			if (xml.child("image").length() > 0) {
				special.imageUrl = xml..image;
			}
			return special;
		}
		
		public static function makeAlly(xml:XML):Ally {
			var ally:Ally = new Ally();
			ally.id = parseFloat(xml.@id) as int;
			ally.num = parseFloat(xml.@num) as int;
			ally.name = xml..name;
			ally.text = xml..text;
			if (xml.child("image").length() > 0) {
				ally.imageUrl = xml..image;
			}
			return ally;
		}
		
		public static function getGateTokenId(gateId:int, gateNum:int):String {
			return new String("gate_" + Config.i.gameId + "_" + gateId + "_" + gateNum);
		}
		
		public static function getCardInstanceId(type:String, sourceId:int, instanceNum:int):String {
			return new String(type + "_" + Config.i.gameId + "_" + 	sourceId + "_" + instanceNum);
		}
				
		public static function getGateTokenXML(gate:GateInstance):XML {
			var xml:XML = new XML("<gate></gate>");
			xml.@id = gate.id;
			xml.@source = gate.source.id;
			if (gate.isTrophy) {
				xml.@trophy = "true";
				xml.@owner = gate.claimant.id;
			} else {
				xml.@trophy = "false";
				if (gate.location) {
					xml.@location = gate.location.mapId;
				} else {
					xml.@location = "cup";
				}
			}
			return xml;
		}
		
		public static function makeGateToken(xml:XML):GateInstance {
			var gateToken:GateInstance = new GateInstance();
			gateToken.id = xml.@id;
			gateToken.locationId = xml.@location;
			if (xml.@trophy == "true") {
				gateToken.isTrophy = true;
			} else {
				gateToken.isTrophy = false;
			}
			return gateToken;
		}
		
		public static function getCardInstanceXML(card:CardInstance):XML {
			var xml:XML = new XML("<item></item>");
			xml.@id = card.id;
			xml.@source = card.source.id;
			if (card.isInPlay) {
				xml.@inplay = "true";
				xml.@owner = card.owner.id;
			} else {
				xml.@inplay = "false";
			}
			return xml;
		}
		
		public static function makeCardInstance(xml:XML):CardInstance {
			var card:CardInstance = new CardInstance();
			card.id = xml.@id;
			if (xml.@inplay == "true") {
				card.isInPlay = true;
			} else {
				card.isInPlay = false;
			}
			return card;
		}
	}
}