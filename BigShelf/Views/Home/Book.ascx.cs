﻿using System.Web.UI;
using System.Web.UI.WebControls;

namespace BigShelf.Views.Home
{
	public partial class Book : UserControl
	{
		protected void Page_CallingDataMethods(object sender, CallingDataMethodsEventArgs e)
		{
			e.DataMethodsObject = Page.Items["controller"];
		}
	}
}