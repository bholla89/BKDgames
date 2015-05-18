package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Dino extends MovieClip {
		
		var speed:Number = 5;
		var hp:int = 0;
		var stoneReward:int = 0;
		var waypoints:Array;
		var currentWP:Number = 0;
		var distanceWP:Number = 0;
		
		public function Dino(wp:Array) {
			// constructor code
			waypoints=wp;
			addEventListener(Event.ENTER_FRAME, updateDino);
			
		}
		
		private function updateDino (e:Event):void
		{
			//get the distance from WP to WP
			distanceWP= getDistanceToWayPoint();			
			if(distanceWP < 5)
			{
				currentWP++;
			}
			
			moveDino();
		}
		
		public function getDistanceToWayPoint():Number
		{
			var dist:Number = -1;
			if(waypoints[currentWP] != null)
			{
			var dx:Number = waypoints[currentWP].x - this.x;
			var dy:Number = waypoints[currentWP].y - this.y;
			dist = Math.sqrt(dx*dx + dy*dy);
			}	
			return dist;
			
		}
		public function moveDino():void
		{
			var dx:Number = waypoints[currentWP].x - this.x;
			var dy:Number = waypoints[currentWP].y - this.y;
			rotation = Math.atan2(dy,dx)/Math.PI*180;
			
			this.x = this.x + Math.cos(this.rotation/180* Math.PI)*speed;
			this.y = this.y + Math.sin(this.rotation/180* Math.PI)*speed;
		}
	}
	
}
