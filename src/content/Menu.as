package content
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import assets.BG;
	
	import button.Help;
	import button.Start;
	
	public class Menu extends Sprite
	{
		private var bg:assets.BG;
		private var help:Help;
		private var start:Start;
		public function Menu()
		{
			super();
			init();
		}
		
		private function init():void
		{
			bg = new BG();
			addChild(bg);
			help = new Help();
			help.x = 57;
			help.y = 338;
			addChild(help);
			start = new Start();
			start.x = 422;
			start.y = 316;
			addChild(start);
			help.addEventListener(MouseEvent.CLICK,onHelp);
			start.addEventListener(MouseEvent.CLICK,onStart);
		}
		
		protected function onStart(event:MouseEvent):void
		{
			Container.eventId = int(bg.t1.text)
			FlowingText.fontSize = int(bg.t2.text);
			FlowingText.speed = int(bg.t3.text);
			this.parent.addChild(new Container());
			this.parent.removeChild(this);
		}
		
		protected function onHelp(event:MouseEvent):void
		{
			//http://cucfun.com/app/1/?help
			navigateToURL(new URLRequest("http://cucfun.com/app/1/?help"));
		}
	}
}