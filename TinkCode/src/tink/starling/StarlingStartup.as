package tink.starling
{
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	import tink.layer.LayerManager;
	import tink.layer.LayerType;

	/**
	 *starling 启动项 
	 * @author Tink
	 * 
	 */	
	public class StarlingStartup
	{
		private static var _starling:Starling;
		private static var _stage:Stage;
		
		private static var _callBack:Function;
		
		public function StarlingStartup()
		{
			
		}
		
		public static function setup(stage:Stage, callBack:Function):void
		{
			_stage = stage;
			
			_callBack = callBack;
			StarlingRoot.callBack = starlingInitComplete;
			
			var viewPort:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			_starling = new Starling(StarlingRoot, stage, viewPort);
			_starling.showStats = true;
			_starling.start();
		}
		
		private static function starlingInitComplete():void
		{
			LayerManager.instance.setup2DLayer(_stage, [LayerType.STAGE2D_BOTTOM, LayerType.STAGE2D_NORMAL, LayerType.STAGE2D_UP]);
			LayerManager.instance.setupStarlingLayer(_starling.root as StarlingRoot, [LayerType.STARLING_BOTTOM, LayerType.STARLING_NORMAL, LayerType.STARLING_UP]);
			_callBack();
		}
	}
}