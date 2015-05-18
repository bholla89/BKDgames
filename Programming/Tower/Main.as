﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	
	
	public class Main extends MovieClip {
		
		var ma:MenuArea;
		var pa:PlayArea;
		var ia:InfoArea;
		var twr:Tower;
		var range:Range = new Range(100);
		var waypointObject:DisplayObject;
		var currStone:int;
		var currEggs:int;
		var sendDino:Boolean = true;
		var dino:Dino;
		var maxDino:int = 0;
		
		//Arrays
		var waypoints:Array;
		var dinos:Array;
		var bullets:Array;
		var towers:Array;
		
		public function Main() 
		{
			// constructor code
			//set arrays
			waypoints = new Array();
			dinos = new Array;
			bullets = new Array;
			towers = new Array;
			
			//starting data 
			currStone = 100;
			currEggs = 10;
			
			//load functions
			setArea();
			LoadWaypoints();
			initDino();
		}
		
		/*public function MainGame():void
			{
				setArea();
			}*/
			
		public function setArea():void
			{
				pa = new PlayArea();// load play area
				pa.x = 100;
				pa.y = 0;
				addChild(pa);
				
				ma = new MenuArea();// load menu
				ma.x = 0;
				ma.y = 0;
				addChild(ma);

				ia = new InfoArea();// load info
				ia.x = 100;
				ia.y = 600;
				addChild(ia);
				ia.txtStone.text = currStone.toString();
				ia.txtEggs.text = currEggs.toString();
				
				//places all three towers in the menu area 
				//tile background    //icon      //cost				
				ma.addTile(new Tile1(new Stone(1,2,3), 100, function () { return new Stone(1,2,3)}));
				ma.addTile(new Tile1(new Spear(1,2,3), 100, function () { return new Spear(1,2,3)}));
				ma.addTile(new Tile1(new Club(1,2,3), 100, function () { return new Club(1,2,3)}));
			}
		public function addTower(t:Tower):void
		{
			this.addChild(range);
			twr = t;
			twr.x = mouseX;
			twr.y = mouseY;
			twr.startDrag();
			addChild(twr);
			range.visible = true;
			addEventListener(MouseEvent.MOUSE_UP, releaseTower);
			addEventListener(Event.ENTER_FRAME, setRange);
		}
		
		private function releaseTower(me:MouseEvent):void
		{
			if(twr.x > 100 && twr.y < 600)//makes sure the tower is in the playArea 
			{
				twr.stopDrag();
				range.visible = false;
			}
			else
			{
				//make range go circle go red
			}
		}
		
		private function setRange(e:Event):void
		{
			range.x = twr.x;
			range.y = twr.y;
		}
		
		public function makeBullet(tx:int, ty:int):void
		{
			var bullet:Bullet = new Bullet();
			bullet.x = tx;
			bullet.y = ty;
			//bullet.rotation = tr;
			bullets.push(bullet);
			this.addChild(bullet);
		}
		
		public function LoadWaypoints():void
		{
			var i:int = 1;
			waypointObject = pa.getChildByName("WP" + i);
			//waypointObject.alpha = 0;
			//trace(pa.getChildByName("WP" + i));
			while(waypointObject != null)//loads the waypoints, allows us to reuse the code for any level 
										 //and we can have as many way points as we want
			{
				waypoints.push(waypointObject);
				i++;
				waypointObject = pa.getChildByName("WP" + i);
				//waypointObject.alpha = 0;
			}
		}
		
		private function initDino():void
		{
			//maxDino = 0;
			//while(maxDino >=10)
			//{
				if(sendDino == true)
					{
						var randomDino:int = 1;//Math.random()*4+1;
						switch(randomDino)
						{
						case 1:
							dino = new Trex(waypoints);
						break;
					 
						case 2:
							dino = new Raptor1(waypoints);
						break;
					 
						case 3:
							dino = new Raptor2(waypoints);
						break;
						
						/*case 4:
							dino = new Spino(waypoints);
						break;*/
						
						default:
							dino = new Trex(waypoints);
							break;
					 
						}
					}
				//maxDino++;
			//}
			 
			//dinoDelay--;
			dino.x = 920;
			dino.y = 50;
			//dino.rotation = Math.random()*360;
			dinos.push(dino);
			pa.addChild(dino);
		}
		
	}
	
}
