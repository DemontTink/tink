package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import tink.starling.StarlingStartup;
	
	[SWF(width="1280", height="720", frameRate="60")]
	public class TinkStartup extends Sprite
	{
		public function TinkStartup()
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
			
		}
	}
}