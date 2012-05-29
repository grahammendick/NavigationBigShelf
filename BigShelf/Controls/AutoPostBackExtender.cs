using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BigShelf.Controls
{
	[TargetControlType(typeof(Control))]
	public class AutoPostBackExtender : ExtenderControl, IPostBackEventHandler
	{
		private static readonly object EventCommand = new object();

		public string Trigger
		{
			get
			{
				return ViewState["Trigger"] != null ? (string)ViewState["Trigger"] : string.Empty;
			}
			set
			{
				ViewState["Trigger"] = value;
			}
		}

		public int Throttle
		{
			get
			{
				return ViewState["Throttle"] != null ? (int)ViewState["Throttle"] : 0;
			}
			set
			{
				ViewState["Throttle"] = value;
			}
		}

		public string CommandName
		{
			get
			{
				return ViewState["CommandName"] != null ? (string)ViewState["CommandName"] : string.Empty;
			}
			set
			{
				ViewState["CommandName"] = value;
			}
		}

		public string CommandArgument
		{
			get
			{
				return ViewState["CommandArgument"] != null ? (string)ViewState["CommandArgument"] : string.Empty;
			}
			set
			{
				ViewState["CommandArgument"] = value;
			}
		}

		public event CommandEventHandler Command
		{
			add
			{
				Events.AddHandler(EventCommand, value);
			}
			remove
			{
				Events.RemoveHandler(EventCommand, value);
			}
		}

		protected override void Render(HtmlTextWriter writer)
		{
			Page.ClientScript.RegisterForEventValidation(UniqueID);
			writer.AddAttribute(HtmlTextWriterAttribute.Id, ClientID);
			writer.RenderBeginTag(HtmlTextWriterTag.Span);
			writer.RenderEndTag();
			base.Render(writer);
		}

		protected override IEnumerable<ScriptDescriptor> GetScriptDescriptors(Control targetControl)
		{
			ScriptBehaviorDescriptor descriptor = new ScriptBehaviorDescriptor("BigShelf.AutoPostBackBehavior", targetControl.ClientID);
			descriptor.AddProperty("uniqueID", UniqueID);
			descriptor.AddProperty("trigger", Trigger);
			descriptor.AddProperty("throttle", Throttle);
			return new ScriptDescriptor[] { descriptor };
		}

		protected override IEnumerable<ScriptReference> GetScriptReferences()
		{
			ScriptReference reference = new ScriptReference();
			reference.Path = "~/Controls/AutoPostBackBehavior.js";
			return new ScriptReference[] { reference };
		}

		protected virtual void OnCommand(CommandEventArgs e)
		{
			CommandEventHandler commandEventHandler = (CommandEventHandler)Events[EventCommand];
			if (commandEventHandler != null)
				commandEventHandler(this, e);
			RaiseBubbleEvent(this, e);
		}

		public void RaisePostBackEvent(string eventArgument)
		{
			Page.ClientScript.ValidateEvent(UniqueID);
			OnCommand(new CommandEventArgs(CommandName, CommandArgument));
		}
	}
}