package
{
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import content.Container;
	import content.Menu;
	import content.Test;
	
	import cutIn.M;

	[SWF(width="1024", height="768")]
	public class Main extends Sprite
	{
		private var torggle:int;
		public var mtorggle:int;
		public var m:M=new M;
		public function Main()
		{
			stage.nativeWindow.alwaysInFront = true;
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addChild(new Menu());
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			
			if(event.keyCode==Keyboard.F) 
			{
				torggle++;
				if(torggle%2==0)
				{
					this.stage.nativeWindow.restore();
				}
				else
				{
					this.stage.nativeWindow.maximize();
				}
				
			}
			else if(event.keyCode==Keyboard.X) 
			{
				addChild(new Menu);
				removeChildAt(0);
			}
			else if(event.keyCode==Keyboard.I) 
			{
				mtorggle++;
				if(mtorggle%2==0)
				{
					removeChild(m);
				}
				else
				{
					addChild(m);
				}
			}
			else if(event.keyCode==Keyboard.K) 
			{
				
			}
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			stage.nativeWindow.startMove();
			
		}
	}
}