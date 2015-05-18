package
{
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		//constants
		const trex_startx:int = -15;
		const trex_starty:int = 125;
		const trex_speed: int = 2;
		const trexNum:    int = 10;
		
		//variables
		var currTower:Tower;
		var currTile:Tile1;
		var currStone:int = 100;
		var totalEggs:int = 5;
		
		//arrays
		var nonPlaceableTiles:Array = new Array();
		var level:Array = new Array();
		var Trexs:Array = new Array();
		var bullets:Array = new Array();
		var towers:Array = new Array();
		var waypoints_x:Array = new Array();
		var waypoints_y:Array  = new Array();
		
		public function Main()
		{
			init();
		}//end main
		
		function init():void
		{
			//x-index- 0 1 2 3 4 5 6 7 8 9 10 11
			/*level=[[0,0,0,0,1,1,1,1,1,0,0,0],        // level is a 2D array that contains 1 and 0.
					 [0,0,0,0,1,0,0,0,1,0,0,0],        // 1 represents a brown tile on which monsters can walk
					 [1,1,0,0,1,0,0,0,1,0,0,0],		   // 0 represents a green tile where towers can be placed
					 [0,1,0,0,1,0,0,0,1,0,0,0],
					 [0,1,0,0,1,0,0,0,1,0,0,0],
					 [0,1,1,1,1,0,0,0,1,0,0,0],
					 [0,0,0,0,0,0,0,0,1,1,1,1],
					 [0,0,0,0,0,0,0,0,0,0,0,0],
					];*/
			//x-index-0 1 2 3 4 5 6 7 8 9 10 11  //y-index
			level=  [[0,0,0,0,0,0,0,0,0,0,1,1],  //0      
					 [0,0,0,0,0,0,1,1,1,0,1,0],  //1      
					 [1,1,1,0,0,0,1,0,1,0,1,0],	 //2
					 [0,0,1,1,0,0,1,0,1,1,1,0],  //3
					 [0,0,0,1,1,1,1,0,0,0,0,0],  //4
					 [0,0,0,0,0,0,0,0,0,0,0,0],  //6
					];
		/*level2=   [[1,1,0,0,0,0,0,0,0,0,0,0],        
					 [0,1,0,0,1,1,1,0,0,0,0,0],        
					 [0,1,0,0,1,0,1,0,0,0,1,1],		   
					 [0,1,0,0,1,0,1,1,1,0,1,0],
					 [0,1,1,1,1,0,0,0,1,1,1,0],
					 [0,0,0,0,0,0,0,0,0,0,0,0],
					];*/
		/*level3=   [[0,0,0,0,0,1,1,1,0,0,0,0],        
					 [0,0,0,1,1,1,0,1,0,0,0,0],        
					 [1,1,0,1,0,0,0,1,0,1,1,1],		   
					 [0,1,0,1,0,0,0,1,0,1,0,0],
					 [0,1,1,1,0,0,0,1,1,1,0,0],
					 [0,0,0,0,0,0,0,0,0,0,0,0],
					];*/
		  //waypoints for where monsters turn. ending point of the path is the waypoint
		  //waypoint_x is for the xindex
		  //waypoint_y is for the yindex
		  waypoints_x = [2,2,3,3,6,6,8,8,10,10,11];
		  waypoints_y = [2,3,3,4,4,1,1,3,3,0,0];
		  
		  //sets waypoints
		  for (var i:int=0;i<waypoints_x.length;++i)
		  {
			  waypoints_x[i]=waypoints_x[i]*50+25;
			  waypoints_y[i]=waypoints_y[i]*50+25;
		  }
			
		  
		  BuildMap();
		  
		  //create trex
		  for(var k:int=0; k<trexNum;++k)
		  {
			  createTrex(trex_startx -k*50,trex_starty);
		  }
		  
		  BtnTower.addEventListener(MouseEvent.MOUSE_UP,TowerBtnUpHandler);
		  stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
		  stage.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
		  
		}//end init
		
		function BuildMap():void{
			for(var i:int =0; i < level.length ; ++i)
			{          
				for(var j:int =0; j < level[i].length ; ++j)
				{  //two loops are needed for accessing elements of a 2D array
					var tmpTile:Tile1 = new Tile1();
			        tmpTile.x = j*50;                          //set the x and y coordinates of the tile
			        tmpTile.y = i*50;
			        addChild(tmpTile);                         //add the tile to the stage
					tmpTile.gotoAndStop(level[i][j]+1);        //set the frame of the tile according to the value in the 2D array
					
					if(level[i][j]==1)
					{
						nonPlaceableTiles.push(tmpTile); //not placeable area
						tmpTile.addEventListener(MouseEvent.ROLL_OVER,TurnOnTile);
						tmpTile.addEventListener(MouseEvent.ROLL_OUT,TurnOffTile);
					}
				}
			}
		}

		
		function TurnOnTile(event:MouseEvent)
		{
			currTile = event.currentTarget as Tile1;
			if(checkPlaceable(currTile) && currTower !=null)
			{
				currTile.gotoAndStop(3);
			}
		}
		
		function TurnOffTile(event:MouseEvent)
		{
			var prevTile = event.currentTarget as Tile1;
			if(prevTile.currentFrame == 3)
			{
				prevTile.gotoAndStop(1);
			}
		}
		
		function createTrex(xpos:int,ypos:int):void
		{
			var tmpTrex:Trex = new Trex();
			tmpTrex.x = xpos;
			tmpTrex.y = ypos;
			addChild(tmpTrex);
			Trexs.push(tmpTrex);//add trex into array
		}
		
		function checkPlaceable(tmpTile:Tile1):Boolean
		{
			for (var i:int = 0; i < nonPlaceableTiles.length; ++i)
			{
				if(nonPlaceableTiles[i] == tmpTile)
				{
					return false;
				}
			}return true;
		}
		
		function distance(A:MovieClip,B:MovieClip):Number
		{
			return Math.pow(Math.pow(B.x-A.x,2) + Math.pow(B.y-A.y,2),0.5);
		}
		
		//this function will move a monster in the game (using a loop we can move all monsters)
		function moveTrex(tmpTrex:Trex,i:int):void {
			var dist_x:Number = waypoints_x[tmpTrex.nextWayPoint] - tmpTrex.x; //distance between the monster
			var dist_y:Number = waypoints_y[tmpTrex.nextWayPoint] - tmpTrex.y; //and the nextWayPoint
			if(Math.abs(dist_y) + Math.abs(dist_x) < 1){   //increase the nextWayPoint if monster 
				++tmpTrex.nextWayPoint;                 //collided with a waypoint
			}
			var angle:Number = Math.atan2(dist_y,dist_x); //compute the angle of the monster
			tmpTrex.x += trex_speed*Math.cos(angle);//update the x position
			tmpTrex.y += trex_speed*Math.sin(angle);//update the y position
			tmpTrex.rotation = angle/Math.PI*180;      //rotate the monster
			if(tmpTrex.x >= 670){                      //remove the monster if it touches the last wayPoint
			removeChild(tmpTrex);
			Trexs.splice(i,1)
			}
			if(tmpTrex.hp <= 0){                       //remove the monster if its hp becomes 0
				currStone += tmpTrex.stone;	        
			    removeChild(tmpTrex);
			    Trexs.splice(i,1)
	        }
		}
		
		function updateTowers(tmpTower:Tower):void
		{
			if(tmpTower.reloadTime == 0)
			{
				for(var i:int = 0; i<Trexs.length;++i)
				{
					if(distance(tmpTower,Trexs[i]) < tmpTower.range)
					{
						var angle:Number = Math.atan2(Trexs[i].y - tmpTower.y, Trexs[i].x -tmpTower.x);
						var tmpBullet:Bullet = new Bullet(angle,Trexs[i]);

						tmpBullet.x = tmpTower.x;
						tmpBullet.y = tmpTower.y;
						addChild(tmpBullet);
						bullets.push(tmpBullet);
						tmpTower.reloadTime=30;
						break;
					}
				}
			}else
			{
				tmpTower.reloadTime -=1;
			}
		}
		
		function onEnterFrameHandler(event:Event):void
		{
			if(Trexs.length <= 0)
			{              
			    gotoAndStop(2);
				stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				return;
			}
			
			for(var i:int = 0; i < Trexs.length;i++) //update T-Rex
			{
				moveTrex(Trexs[i],i);
			}
			
			for(var t:int=0; t<towers.length;++t)//update towers
			{
				updateTowers(towers[t]);
			}
			
			for(var b:int=0; b<bullets.length;++i) // update bullets
			{
				if(!bullets[b].remove)
				{
					bullets[b].update();
				}
				else
				{
					removeChild(bullets[b]);
					bullets.splice(b,1)
				}
			}
			
			if(currTower != null)
			{
				currTower.x = mouseX + 1 + currTower.width/2;
				currTower.y = mouseY + 1 + currTower.height/2;
			}
			txtStone.text = String(currStone);
		}
		
		function TowerBtnUpHandler(event:MouseEvent)
		{
			if(currTower == null)
			{
				currTower = new Tower();
				addChild(currTower);
			}
		}
		//this function will place the tower when user clicks on the stage
		function onMouseDownHandler(event:MouseEvent){
			if(currTower != null){
				if(checkPlaceable(currTile)){                           //check if placable
				if((currStone-currTower.cost)>=0){                      //check if there is enough Stone to place the 
				if(mouseX < 550){                                      //tower
					txtStatus.text = "";
					currStone -= currTower.cost;
					towers.push(currTower);
					currTower.x = currTile.x + currTile.width/2;        //place the tower on the tile
				    currTower.y = currTile.y + currTile.height/2;
				    currTower = null;
					nonPlaceableTiles.push(currTile);                    //add the current Tile into nonPlacableTiles
				}                                                       //after placing the tower
				}else{
					txtStatus.text = "not enough Stone";
				}                                                           
			    }
				if(mouseX >500 && mouseX<600){
				   removeChild(currTower);
				   currTower = null;
			    }
			}
		}
	}
}