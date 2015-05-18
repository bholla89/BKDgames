package  {
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	
	public class Range extends Sprite {
		
		var range:int = 10;
		var center:Point;
		
		public function Range(r:int) {
			// constructor code
			range = r;
			this.width = 2*r;
			this.height = 2*r;
			this.alpha = .55;
		}
	}
	
}
