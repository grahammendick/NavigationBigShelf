namespace BigShelf.Controllers
{
	public class FilterViewModel
	{
		public string Title
		{
			get;
			set;
		}

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

		public string Filter
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