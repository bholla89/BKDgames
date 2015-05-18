package  {
	
	import flash.display.MovieClip;
	
	
	public class MenuArea extends MovieClip {
		
		var tiles:Array;
		
		public function MenuArea() {
			// constructor code
			tiles = new Array();
			
		}
		//creates the tiles for the towers to sit under
		public function addTile(t:Tile1):void
		{
			t.x = 10;
			t.y = tiles.length*105 + 20;
			tiles.push(t);
			addChild(t);
		}
	}
	
}
