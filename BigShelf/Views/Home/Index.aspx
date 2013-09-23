<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BigShelf.Views.Home.Index" MasterPageFile="~/Views/Shared/Layout.Master" Theme="Site" ViewStateMode="Disabled" %>
<%@ Register src="Book.ascx" tagname="Book" tagprefix="book" %>
<%@ Register src="Paging.ascx" tagname="Paging" tagprefix="page" %>
<%@ Register src="SortAndFilter.ascx" tagname="SortAndFilter" tagprefix="saf" %>
<%@ Register Assembly="Navigation" Namespace="Navigation" TagPrefix="nav" %>
<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <asp:ScriptManager ID="ScriptManager" runat="server" EnableHistory="true" EnableSecureHistoryState="false" LoadScriptsBeforeUI="false">
		<Scripts>
			<asp:ScriptReference Name="Navigation.HTML5History.js" Assembly="Navigation" />
			<asp:ScriptReference Path="~/Scripts/jquery-1.7.2.min.js" />
			<asp:ScriptReference Path="~/Scripts/jquery.rating.pack.js" />
			<asp:ScriptReference Path="~/Scripts/Site.js" />
		</Scripts>
    </asp:ScriptManager>
    <saf:SortAndFilter ID="SortAndFilter" runat="server" />
    <asp:UpdatePanel ID="BookPanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
        <ContentTemplate>
            <asp:ListView ID="BookList" runat="server" ItemType="BigShelf.Models.Book" SelectMethod="GetBooksForSearch" OnCallingDataMethods="Page_CallingDataMethods" ViewStateMode="Enabled">
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
    <nav:HistoryNavigator ID="Navigator" runat="server" HistoryKeys="filter,friends,sort,title,page" StateKeys="TotalItems" />
</asp:Content>