package button
{
	
	import assets.Start;
	
	public class Start extends Button
	{
		private var start:assets.Start;
		public function Start()
		{
			start = new assets.Start();
			super(start);
			this.addChild(start);
		}
	}
}