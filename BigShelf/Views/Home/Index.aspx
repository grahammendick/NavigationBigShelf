<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BigShelf.Views.Home.Index" MasterPageFile="~/Views/Shared/Layout.Master" Theme="Site" %>
<%@ Register src="Book.ascx" tagname="Book" tagprefix="book" %>
<%@ Register src="Paging.ascx" tagname="Paging" tagprefix="page" %>
<%@ Register src="SortAndFilter.ascx" tagname="SortAndFilter" tagprefix="saf" %>
<%@ Register Assembly="Navigation" Namespace="Navigation" TagPrefix="nav" %>
<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <asp:ScriptManager ID="ScriptManager" runat="server" EnableHistory="true" EnableSecureHistoryState="false">
		<Scripts>
			<asp:ScriptReference Name="Navigation.HTML5History.js" Assembly="Navigation" />
		</Scripts>
    </asp:ScriptManager>
    <saf:SortAndFilter ID="SortAndFilter" runat="server" />
    <asp:UpdatePanel ID="BookPanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
        <ContentTemplate>
            <asp:ListView ID="BookList" runat="server" ItemType="BigShelf.Models.Book" SelectMethod="GetBooksForSearch" OnCallingDataMethods="Page_CallingDataMethods">
                <LayoutTemplate>
                    <ul class="books clearfix"><li id="itemPlaceHolder" runat="server" /></ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li>
                        <asp:HiddenField ID="id" runat="server" Value='<%# Item.Id %>' Visible="false" />
                        <book:Book ID="Book" runat="server" />
                    </li>
                </ItemTemplate>
            </asp:ListView>
        </ContentTemplate>
        <Triggers>
            <nav:NavigationDataTrigger Key="filter" />
            <nav:NavigationDataTrigger Key="friends" />
            <nav:NavigationDataTrigger Key="sort" />
            <nav:NavigationDataTrigger Key="title" />
            <nav:NavigationDataTrigger Key="page" />
        </Triggers>
    </asp:UpdatePanel>
    <page:Paging ID="Paging" runat="server" />
    <nav:HistoryNavigator ID="Navigator" runat="server" />
    <script type="text/javascript">
        $(function () {
            $("html").addClass('js')
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
                $(".ratings input[value!='0']").rating({ required: true });
                $(".ratings input[value='0']").hide();
            });
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(function (sender, args) {
                $(args.get_postBackElement()).parents('.coverCol, .details').siblings('.coverCol, .details').andSelf().addClass('updating');
            });
        });
    </script>
</asp:Content>