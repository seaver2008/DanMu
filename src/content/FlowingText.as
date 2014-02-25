package content
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class FlowingText extends MovieClip
	{
		static public var row:int;
		private var message:String;
		private var text:TextField;
		static public var speed:int;
		static public var fontSize:int;
		private var innerSpeed:Number;
		private var isOver:Boolean = false;
		private var font:String;
		private var random:int
		public function FlowingText(t:String,random:int=0)
		{
			super();
			this.random = random;
			var allFonts:Array = Font.enumerateFonts(true);
			allFonts.sortOn("fontName", Array.CASEINSENSITIVE);
			for (var i:uint=0; i<allFonts.length; i++) {
				if (allFonts[i].fontName=="微软雅黑") 
				{
					font = "微软雅黑";
					trace(font);
					break;
					
				}
				else if(allFonts[i].fontName=="黑体") {
					font = "黑体";
					trace(font);
					break;
				}
				else font = "sans-serif";
				//trace(allFonts[i].fontName);
			}
			
			row++;
			
			message = t;
			text = new TextField;
			text.text = message;
			addChild(text);
			TweenMax.to(text, 1, {dropShadowFilter:{color:0x000000, alpha:1, angle:0, distance:2}});
			text.x = 1024+text.width;
			text.y = row*(fontSize+2);
			if(text.y+text.height>768) 
			{
				row = 0;
				text.y = 0;
			}
			text.autoSize = TextFieldAutoSize.LEFT;
			text.textColor = 0xffffff;
			var textFormat:TextFormat = new TextFormat;
			textFormat.size = fontSize;
			textFormat.font = font;
			text.setTextFormat(textFormat);
			
			
			innerSpeed = speed;
			innerSpeed += 0.006*text.width;
			if(innerSpeed>=2*speed) innerSpeed=2*speed;
			
			addEventListener(Event.ENTER_FRAME,onEnterframe);
		}
		
		protected function onEnterframe(event:Event):void
		{
			
			text.x -= innerSpeed+random;
			
			
			if(text.x+text.width<=0) {
				over();
			}
		}
		
		private function over():void
		{
			
			if (!isOver) {
				if(row>=4)row = 0;
				this.parent.removeChild(this);
			}
			isOver = true;
		}
		
	}
}