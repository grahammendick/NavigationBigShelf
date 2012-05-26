<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BigShelf.Views.Home.Index" MasterPageFile="~/Views/Shared/Layout.Master" %>
<asp:Content ID="C" runat="server" ContentPlaceHolderID="Content">
    <asp:ListView ID="BookList" runat="server" ItemType="BigShelf.Models.Book" SelectMethod="GetBooksForSearch" OnCallingDataMethods="Page_CallingDataMethods">
        <LayoutTemplate>
            <ul class="books clearfix"><li id="itemPlaceHolder" runat="server" /></ul>
        </LayoutTemplate>
        <ItemTemplate>
            <li>
                <%#: Item.Title %>
            </li>
        </ItemTemplate>
    </asp:ListView>
</asp:Content>