<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BigShelf.Views.Home.Index" MasterPageFile="~/Views/Shared/Layout.Master" %>
<%@ Register src="Book.ascx" tagname="Book" tagprefix="book" %>
<asp:Content ID="C" runat="server" ContentPlaceHolderID="Content">
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
</asp:Content>