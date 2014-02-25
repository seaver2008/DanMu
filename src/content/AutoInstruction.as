package content
{
	import flash.display.MovieClip;
	
	import cutIn.A;
	
	public class AutoInstruction extends MovieClip
	{
		private var a:A = new A;
		public var innerRow:int=99;
		public function AutoInstruction()
		{
			super();
			this.addChild(a);
		}
	}
}