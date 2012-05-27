<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Paging.ascx.cs" Inherits="BigShelf.Views.Home.Paging" %>
<%@ Register Assembly="Navigation" Namespace="Navigation" TagPrefix="nav" %>
Results:
<asp:ListView ID="PagingList" runat="server" ItemType="BigShelf.Controllers.PagingViewModel" SelectMethod="GetPages" OnCallingDataMethods="Page_CallingDataMethods">
    <LayoutTemplate>
        <ul class="paging"><li id="itemPlaceHolder" runat="server" /></ul>
    </LayoutTemplate>
    <ItemTemplate>
        <li>
            <nav:NavigationHyperLink ID="pageLink" runat="server" ToData='<%# new NavigationData(){{ "page" , Item.Index }} %>' Text='<%#: Item.GroupText %>' Direction="Refresh" IncludeCurrentData="true" />
        </li>
    </ItemTemplate>
    <EmptyDataTemplate>
        <strong>None</strong>
    </EmptyDataTemplate>
</asp:ListView>