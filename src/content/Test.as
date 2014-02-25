package content
{
	public class Test
	{
		public function Test()
		{
			var text:String = "ab,cd";
			var ta:Array = text.split(",");
			trace(ta[1]);
		}
	}
}