package content
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import cutIn.A;
	
	public class Container extends Sprite
	{
	    static public var eventId:int;
		
		private var textData:Array = new Array();
		private var timer:Timer;
		private var time:int;
		private var JSONLength:int;
		private var maxID:int;
		private var json:Object;
		private var font:String;
		private static var instruction:Boolean;
		private static var tempTimer:int;
		
		private var specialText:Array;
		
		
		private var autoImage:AutoInstruction;
		
		public function Container()
		{
			super();
			init();
		}
		
		private function init():void
		{
			
			this.graphics.beginFill(0xffffff);
			this.graphics.drawCircle(1024-5,768-5,5);
			this.graphics.endFill();
			this.graphics.beginFill(0xffffff);
			this.graphics.drawCircle(5,5,5);
			this.graphics.endFill();
			
			getSpecialData("http://cucfun.com/api/topic/id/+"+eventId+"/get/keyword/");
			
			timer = new Timer(2000);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
			timer.start();
			
			instruction = false;
			autoImage = new AutoInstruction();
			
			
			
		}
		
		
		
		protected function onTimer(event:TimerEvent):void
		{
			//stage.displayState=StageDisplayState.FULL_SCREEN;
			getInt("http://cucfun.com/api/topic/id/"+eventId+"/get/lastId/");
			time++;
			
			if(maxID!=0&&numChildren==0) 
			{
				addChild(new FlowingText(textData[Math.floor(3*Math.random())]));
			}
			
			
			//trace(time+" "+tempTimer+" "+instruction);
			if(time==150) //3000 = 5min
			{
				if(!instruction&&numChildren<=1) 
				{
					addChild(autoImage);
					instruction=true;
				}
				time = 0;
			}
			if(instruction)
			{
				tempTimer++;
				if(tempTimer>=30)
				{
					removeChild(autoImage);
					instruction = false;
					tempTimer = 0;
				}
			}
		}
		
		
		private function getInt(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));//这里是你要获取JSON的路径
			urlLoader.addEventListener(Event.COMPLETE, decodeIntHandler);
		}
		
		protected function decodeIntHandler(event:Event):void
		{
			
			
			var tempInt:int = com.adobe.serialization.json.JSON.decode( URLLoader( event.target ).data ).data;
			if (maxID < tempInt)
			{
				getRandomData("http://cucfun.com/api/message/id/"+eventId+"/get/new/limit/3/");
				if(maxID!=0)
				{
					if(tempInt-1==maxID) getJSON("http://cucfun.com/api/message/id/"+eventId+"/get/new/limit/1/");
					else if(tempInt-1>maxID) getJSON("http://cucfun.com/api/message/id/"+eventId+"/get/between/from/"+(maxID+1)+"/to/"+tempInt+"/");
				}
				
				maxID = tempInt;
				
				
			}
		}
		
		private function getJSON(url:String):void
		{
			/*
			关于最新ID
			这里说明一下，获取当前活动的最新ID的API接口地址为：
			http://cucfun.com/api/topic/id/1/get/lastId/
			
			新的接口示范：
			http://cucfun.com/api/message/id/1/get/between/from/2/to/3/
			http://cucfun.com/api/message/id/1/get/new/limit/2/
			*/
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));//这里是你要获取JSON的路径
			urlLoader.addEventListener(Event.COMPLETE, decodeJSONHandler);
		}
		protected function decodeJSONHandler(event:Event):void
		{
			
			json = com.adobe.serialization.json.JSON.decode( URLLoader( event.target ).data ).data;
			//获取数组中存储的数据
			JSONLength = json.length;
			for(var i:int=0;i<=JSONLength-1;i++){
				
				addChild(new FlowingText(json[i].content));
				for(var j:int=0;j<=specialText.length-1;j++)
				{
					var jsonContent:String = json[i].content;
					if(jsonContent.toLowerCase().lastIndexOf(specialText[j].toLowerCase())!=-1) showSpecialData(jsonContent);
					//if(specialText[j].toLowerCase()==jsonContent.toLowerCase()) showSpecialData(specialText[j]);     .lastIndexOf("the")
				}
			}
			
		}
		
		private function showSpecialData(s:String):void
		{
			var maxRoll:int = int(768/FlowingText.fontSize);
			FlowingText.row = 1;
			for(var i:int=0;i<=maxRoll-2;i++)
			{
				addChild(new FlowingText(s,Math.random()*5));
			}
		}
		private function getSpecialData(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));//这里是你要获取JSON的路径
			urlLoader.addEventListener(Event.COMPLETE, onSpecialData);
		}
		protected function onSpecialData(event:Event):void
		{
			specialText = com.adobe.serialization.json.JSON.decode( URLLoader( event.target ).data ).data.split(",");
		}
		
		private function getRandomData(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));//这里是你要获取JSON的路径
			urlLoader.addEventListener(Event.COMPLETE, onRandomlData);
		}
		
		protected function onRandomlData(event:Event):void
		{
			var randomdata:Object = com.adobe.serialization.json.JSON.decode( URLLoader( event.target ).data ).data;
			for(var i:int=0;i<=randomdata.length-1;i++)
			{
				textData[i] = randomdata[i].content;
			}
				
		}
		
		
		
	}
}