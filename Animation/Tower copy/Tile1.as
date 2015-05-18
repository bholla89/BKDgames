package  {
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.text.engine.TabAlignment;
	
	public class Tile1 extends MovieClip {
		
		public var createTower: Function;
		private var cost:int;
		public var range:int;
		
		public function Tile1(img:DisplayObject,//image for tower
							  cost:int,//cost of tower
							  createTower:Function) //function to send new tower to the tile
		{
			this.createTower = createTower;
			this.cost = cost;
			
			img.x = 40;
			img.y = 45;
			addChild(img);
			addEventListener(MouseEvent.MOUSE_DOWN, spawnTower);
			
		}
		
		public function spawnTower(e:MouseEvent):void
		{
			var t:Tower =  createTower() as Tower;
			
			if(t !=null)
			{
				t.x = 10;
				t.y = 10;
				(root as Main).addTower(t);
			}
		}
	}
	
}
