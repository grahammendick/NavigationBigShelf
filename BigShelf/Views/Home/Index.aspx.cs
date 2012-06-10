using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using BigShelf.Controllers;
using Navigation;

namespace BigShelf.Views.Home
{
	public partial class Index : Page
	{
		protected void Page_PreInit(object sender, EventArgs e)
		{
			Page.Items["controller"] = new BigShelfController();
		}

		protected void Page_CallingDataMethods(object sender, CallingDataMethodsEventArgs e)
		{
			e.DataMethodsObject = Page.Items["controller"];
		}

		protected void Page_SaveStateComplete(object sender, EventArgs e)
		{
			StateContext.Bag.TotalItems = null;
		}
	}
}