using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using BigShelf.Controllers;

namespace BigShelf.Views.Home
{
	public partial class Index : Page
	{
		protected void Page_PreInit(object sender, EventArgs e)
		{
			Page.Items[typeof(BigShelfController)] = new BigShelfController();
		}

		protected void Page_CallingDataMethods(object sender, CallingDataMethodsEventArgs e)
		{
			e.DataMethodsObject = Page.Items[typeof(BigShelfController)];
		}

	}
}