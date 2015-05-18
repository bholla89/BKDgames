package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Bullet extends MovieClip {
		
		var speed:Number = 15;
		var startPosition:Point = new Point;
		
		public function Bullet() {
			// constructor code
			addEventListener(Event.ENTER_FRAME,updateBullet);
		}
		
		public function updateBullet(e:Event):void
		{
			this.x = this.x + Math.cos(this.rotation/180* Math.PI)*speed;
			this.y = this.y + Math.sin(this.rotation/180* Math.PI)*speed;
		}
		
		public function getStartPosition():Point
		{
			return startPosition;
		}
		
		public function setStartPosition(sp:Point):void
		{
			startPosition = sp;
		}
	}
	
}

