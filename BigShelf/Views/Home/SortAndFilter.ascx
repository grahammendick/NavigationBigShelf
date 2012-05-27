<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SortAndFilter.ascx.cs" Inherits="BigShelf.Views.Home.SortAndFilter" %>
<%@ Register Assembly="Navigation" Namespace="Navigation" TagPrefix="nav" %>
<div class="sortAndFilter">
    <asp:ListView ID="FilterList" runat="server" ItemType="BigShelf.Controllers.FilterViewModel" SelectMethod="GetFilterOptions" OnCallingDataMethods="Page_CallingDataMethods">
        <LayoutTemplate>
            <label>Show me:</label>
            <ul><li id="itemPlaceHolder" runat="server" /></ul>
        </LayoutTemplate>
        <ItemTemplate>
            <li>
                <nav:NavigationHyperLink ID="filterLink" runat="server" ToData='<%# new NavigationData(){{ "filter" , Item.Filter }, { "page", "" }} %>' Text='<%#: Item.Text %>' Direction="Refresh" IncludeCurrentData="true" />
            </li>
        </ItemTemplate>
    </asp:ListView>
    <asp:ListView ID="SortList" runat="server" ItemType="BigShelf.Controllers.SortViewModel" SelectMethod="GetSortOptions" OnCallingDataMethods="Page_CallingDataMethods">
        <LayoutTemplate>
            <label>Sort by:</label>
            <ul><li id="itemPlaceHolder" runat="server" /></ul>
        </LayoutTemplate>
        <ItemTemplate>
            <li>
                <nav:NavigationHyperLink ID="sortLink" runat="server" ToData='<%# new NavigationData(){{ "sort" , Item.Sort }, { "sortAscending" , Item.Ascending }, { "page", "" }} %>' Text='<%#: Item.Text %>' Direction="Refresh" IncludeCurrentData="true" />
            </li>
        </ItemTemplate>
    </asp:ListView>
</div>