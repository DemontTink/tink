package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import socket.SocketManager;
	
	import tink.starling.StarlingStartup;
	
	[SWF(width="400", height="600", frameRate="60")]
	public class TTalkServer extends Sprite
	{
		public function TTalkServer()
		{
			addEventListener(Event.ADDED_TO_STAGE,__addToStage);
		}
		
		private function __addToStage(event:Event):void
		{
			// TODO Auto-generated method stub
			StarlingStartup.setup(stage, callBack);
		}
		
		private function callBack():void
		{
			// TODO Auto Generated method stub
			SocketManager.instance.setupServer();
		}
	}
}