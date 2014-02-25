package button
{
	
	import assets.Help;
	
	public class Help extends Button
	{
		private var help:assets.Help;
		public function Help()
		{
			help = new assets.Help;
			super(help);
			this.addChild(help);
		}
	}
}