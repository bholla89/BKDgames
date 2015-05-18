package
{
	import flash.display.*;
	import flash.display.MovieClip;
	
	

		public class Maps extends MovieClip
	{
		static var map:Array = new Array(2);

		map=     [ 
					[[0,0,0,0,1,1,1,1,1,0,0,0],        // level is a 2D array that contains 1 and 0.
					 [0,0,0,0,1,0,0,0,1,0,0,0],        // 1 represents a brown tile on which monsters can walk
					 [1,1,0,0,1,0,0,0,1,0,0,0],		   // 0 represents a green tile where towers can be placed
					 [0,1,0,0,1,0,0,0,1,0,0,0],
					 [0,1,0,0,1,0,0,0,1,0,0,0],
					 [0,1,1,1,1,0,0,0,1,0,0,0],
					 [0,0,0,0,0,0,0,0,1,1,1,1],
					 [0,0,0,0,0,0,0,0,0,0,0,0],
					],
					[[1,1,0,0,1,1,1,0,0,0,0,0],        
					 [0,1,0,0,1,0,1,0,0,1,1,1],        
					 [0,1,1,1,1,0,1,0,0,1,0,0],		   
					 [0,0,0,0,0,0,1,0,0,1,0,0],
					 [0,1,1,1,1,1,1,0,0,1,0,0],
					 [0,1,0,0,0,0,0,0,0,1,0,0],
					 [0,1,1,1,1,1,1,1,1,1,0,0],
					 [0,0,0,0,0,0,0,0,0,0,0,0],
					]
				];
					
	private function BuildMap(map_index:int):void{
			for(var i:int =0; i < map[map_index].length ; ++i)
			{          
				for(var j:int =0; j < map[map_index][i].length ; ++j)
				{  //two loops are needed for accessing elements of a 2D array
					var tmpTile:Tile1 = new Tile1();
			        tmpTile.x = j*50;                          //set the x and y coordinates of the tile
			        tmpTile.y = i*50;
			        Main.doc.stage.addChild(tmpTile);                         //add the tile to the stage
					tmpTile.gotoAndStop(map[map_index][i][j]+1);        //set the frame of the tile according to the value in the 2D array
				}
			}
		}
	public function Maps(idx:int)
		{
			BuildMap(idx);
		}
}
}