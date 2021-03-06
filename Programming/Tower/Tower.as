﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	
	public class Tower extends MovieClip {

		private var range:Number;
		private var bulletHP:Number;
		private var cost:Number;
		
		var fireDelay:int = 0;
		var dtd:Number; //distance to dino
		var shortestDistance:Number;
		var currDino:int;
		var d:Array;

		
		public function Tower(r:Number,bht:Number,c:Number) {
			// constructor code
			this.range = r;
			this.bulletHP = bht;
			this.cost = c;
			
			addEventListener(Event.ENTER_FRAME, updateTower);
		}
		
		public function updateTower(e:Event):void
		{
			d = (root as Main).dinos;
			
			shortestDistance = 1000;
			for(var i:int = 0; i < d.length; i++)
			{
				dtd = getDistanceToDino(d[i]);
				if(dtd < shortestDistance)
				{
					shortestDistance = dtd;
					currDino = i;
				}
			} 
			
			
			var dx:Number = (d[currDino].x - this.x);
			var dy:Number = (d[currDino].y - this.y);
			
			
			rotation = Math.atan2(dy,dx)/Math.PI * 180;
			//trace("tower",rotation);
			parent.addEventListener(MouseEvent.CLICK, fireTower);
			fireDelay--;
		}

		public function getDistanceToDino (dino:Dino):Number
		{
			var dx:Number = x - dino.x;
			var dy:Number = y - dino.y;
			
			return Math.sqrt(dx*dx + dy*dy);
		}
		
		public function fireTower(me:MouseEvent):void
		{
			var bullet:Bullet =  new Bullet();
			bullet.x = x;
			bullet.y = y;
			bullet.rotation = rotation;
			
			if(fireDelay < 0)
			{
				parent.addChild(bullet);
			}
			/*if((parent)!= null && fireDelay < 0)
			{
				(parent as MovieClip).makeBullet(x,y);
				fireDelay = 24;
			}*/
		}
	}
	
}
