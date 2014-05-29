package tink.starling
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 *starling root 
	 * @author Tink
	 * 
	 */	
	public class StarlingRoot extends Sprite
	{
		public static var callBack:Function;
		
		public function StarlingRoot()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, __addToStage);
		}
		
		private function __addToStage(event:Event):void
		{
			// TODO Auto Generated method stub			
			callBack();
		}		
		
	}
}