<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BigShelf.Views.Home.Index" MasterPageFile="~/Views/Shared/Layout.Master" %>
<%@ Register src="Book.ascx" tagname="Book" tagprefix="book" %>
<%@ Register src="Paging.ascx" tagname="Paging" tagprefix="page" %>
<%@ Register src="SortAndFilter.ascx" tagname="SortAndFilter" tagprefix="saf" %>
<asp:Content ID="Content" runat="server" ContentPlaceHolderID="Content">
    <saf:SortAndFilter ID="SortAndFilter" runat="server" />
    <asp:ListView ID="BookList" runat="server" ItemType="BigShelf.Models.Book" SelectMethod="GetBooksForSearch" OnCallingDataMethods="Page_CallingDataMethods">
        <LayoutTemplate>
            <ul class="books clearfix"><li id="itemPlaceHolder" runat="server" /></ul>
        </LayoutTemplate>
        <ItemTemplate>
            <li>
			    <asp:HiddenField ID="id" runat="server" Value='<%# Item.Id %>' />
                <book:Book ID="Book" runat="server" />
            </li>
        </ItemTemplate>
    </asp:ListView>
    <page:Paging ID="Paging" runat="server" />
</asp:Content>