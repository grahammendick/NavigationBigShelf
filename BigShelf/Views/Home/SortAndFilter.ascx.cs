using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Navigation;

namespace BigShelf.Views.Home
{
	public partial class SortAndFilter : UserControl
	{
		protected void Page_CallingDataMethods(object sender, CallingDataMethodsEventArgs e)
		{
			e.DataMethodsObject = Page.Items["controller"];
		}

		protected void friendCheck_CheckedChanged(object sender, EventArgs e)
		{
			string friends = StateContext.Bag.friends ?? string.Empty;
			CheckBox checkBox = (CheckBox)sender;
			string friendId = checkBox.Attributes["value"];
			List<string> friendList = friends.Split('.').Where(s => s != string.Empty && s != friendId).ToList();
			if (checkBox.Checked)
				friendList.Add(friendId);
			StateContext.Bag.friends = string.Join(".", friendList);
			StateContext.Bag.page = null;
		}
	}
}