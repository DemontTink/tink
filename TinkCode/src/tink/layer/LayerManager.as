package tink.layer
{
	import flash.display.Stage;
	import flash.utils.Dictionary;
	
	import tink.display.SpriteLayer2D;
	import tink.display.SpriteLayerStarling;
	import tink.starling.StarlingRoot;

	/**
	 * 层管理器
	 * @author Tink
	 * 
	 */	
	public class LayerManager
	{
		private static var _instace:LayerManager;
		
		private var _stageStarling:StarlingRoot;
		private var _stage:Stage;
		
		private var _layers:Dictionary = new Dictionary();
		
		public function LayerManager()
		{
			
		}
		
		public static function get instance():LayerManager
		{
			if(!_instace)
			{
				_instace = new LayerManager();
			}
			return _instace;
		}
		
		/**
		 *初始化starling 层 
		 * @param root
		 * @param layerArr
		 * 
		 */		
		public function setupStarlingLayer(root:StarlingRoot, layerArr:Array):void
		{
			_stageStarling = root;
			
			var sprite:SpriteLayerStarling;
			for (var i:int = 0; i < layerArr.length; ++i) 
			{
				sprite = new SpriteLayerStarling();
				_stageStarling.addChild(sprite);
				_layers[layerArr[i]] = sprite;
			}
		}
		/**
		 *初始化2D层 
		 * @param stage
		 * @param layerArr
		 * 
		 */		
		public function setup2DLayer(stage:Stage, layerArr:Array):void
		{
			_stage = stage;
			
			var sprite:SpriteLayer2D;
			for (var i:int = 0; i < layerArr.length; ++i) 
			{
				sprite = new SpriteLayer2D();
				_stage.addChild(sprite);
				_layers[layerArr[i]] = sprite;
			}
		}
	}
}