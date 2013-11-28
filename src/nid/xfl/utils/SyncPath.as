package nid.xfl.utils 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Nidin Vinayak
	 */
	public class SyncPath 
	{
		
		public function SyncPath() 
		{
			
		}
		public function sync(path:Array):Array
		{
			var cmd:Array = [];
			var p1:Point = new Point();
			var p2:Point = new Point();
			
			p2.x = path[0].commands[path[0].commands.length - 1][path[0].commands[path[0].commands.length - 1].length - 2];
			p2.y = path[0].commands[path[0].commands.length - 1][path[0].commands[path[0].commands.length - 1].length - 1];
			
			var i:int = 0;
			
			cmd.push(path[0]);
			
			while (cmd.length < path.length)
			{
				trace('p2.x:' + p2.x, 'path['+i+'].commands[0][1]:' + path[i].commands[0][1]);
				trace('p2.y:' + p2.y, 'path['+i+'].commands[0][2]:' + path[i].commands[0][2]);
				
				p1.x = path[i].commands[0][1];
				p1.y = path[i].commands[0][2];
				
				p1.x = p1.x > p2.x?Math.floor(p1.x):(p1.x < p2.x?Math.ceil(p1.x):p1.x);
				p1.y = p1.y > p2.y?Math.floor(p1.y):(p1.y < p2.y?Math.ceil(p1.y):p1.y);
				
				if (p2.x ==  p1.x && p2.y ==  p1.y)
				{
					cmd.push(path[i]);
					
					path[i].commands[0][1] = p2.x;
					path[i].commands[0][2] = p2.y;
					
					p2.x = path[i].commands[path[i].commands.length - 1][path[i].commands[path[i].commands.length - 1].length - 2];
					p2.y = path[i].commands[path[i].commands.length - 1][path[i].commands[path[i].commands.length - 1].length - 1];
					
					i = 0;
				}
				
				if (i == path.length - 1)
				{
					trace('---path---');
					for (i = 0; i < path.length; i++)
					{
						trace(path[i].commands);
					}
					trace('---sorted---');
					for (var j:int = 0; j < cmd.length; j++)
					{
						trace(cmd[j].commands);
					}
					return path;
				}
				else {
					i++;
				}
			}
			
			trace('---path---');
			for (i = 0; i < path.length; i++)
			{
				trace(path[i].commands);
			}
			trace('---sorted---');
			for (j = 0; j < cmd.length; j++)
			{
				trace(cmd[j].commands);
			}
			
			return cmd;
		}
		
	}

}