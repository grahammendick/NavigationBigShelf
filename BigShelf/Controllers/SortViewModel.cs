namespace BigShelf.Controllers
{
	public class SortViewModel
	{
		public string Text
		{
			get;
			set;
		}

		public bool Enabled
		{
			get;
			set;
		}

		public string Sort
		{
			get;
			set;
		}

		public bool Ascending
		{
			get;
			set;
		}

		public string CssClass
		{
			get
			{
				return Enabled ? "" : "selected";
			}
		}
	}
}