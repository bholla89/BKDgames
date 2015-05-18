package  {
	
	import flash.display.MovieClip;
	import Main;
	
	public class Bullet extends MovieClip {
		
		var speed:int = 5;
		var target:Trex;
		var angle:Number;
		var remove:Boolean;
		
		public function Bullet(rotate:Number,tmpTrex:Trex) {
			// constructor code
			angle = rotate;
			target=tmpTrex;
			this.rotation = angle/Math.PI*180;
		}
		
		public function update()
		{
			this.x += this.speed*Math.cos(angle);
			this.y += this.speed*Math.sin(angle);
			
			if(this.hitTestObject(target))//test for hit
			{
				target.hp -=10;//reduce hp
				remove=true;//remove bullet
			}
		}
	}
	
}
