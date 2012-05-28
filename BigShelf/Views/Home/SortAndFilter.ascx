<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SortAndFilter.ascx.cs" Inherits="BigShelf.Views.Home.SortAndFilter" %>
<%@ Register Assembly="Navigation" Namespace="Navigation" TagPrefix="nav" %>
<asp:UpdatePanel ID="SortAndFilterPanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false" RenderMode="Inline">
    <ContentTemplate>
        <div class="sortAndFilter">
            <asp:ListView ID="FilterList" runat="server" ItemType="BigShelf.Controllers.FilterViewModel" SelectMethod="GetFilterOptions" OnCallingDataMethods="Page_CallingDataMethods">
                <LayoutTemplate>
                    <label>Show me:</label>
                    <ul><li id="itemPlaceHolder" runat="server" /></ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li>
                        <nav:NavigationHyperLink ID="filterLink" runat="server" ToData='<%# new NavigationData(){{ "filter" , Item.Filter }, { "friends" , Item.Friends }, { "page", "" }} %>' Text='<%#: Item.Text %>' Enabled='<%# Item.Enabled %>' CssClass='<%# Item.CssClass %>' Direction="Refresh" IncludeCurrentData="true" PostBack="true" ClientIDMode="AutoID" />
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
                        <nav:NavigationHyperLink ID="sortLink" runat="server" ToData='<%# new NavigationData(){{ "sort" , Item.Sort }, { "sortAscending" , Item.Ascending }, { "page", "" }} %>' Text='<%#: Item.Text %>' Enabled='<%# Item.Enabled %>' CssClass='<%# Item.CssClass %>' Direction="Refresh" IncludeCurrentData="true" PostBack="true" ClientIDMode="AutoID" />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <asp:FormView ID="SearchForm" runat="server" ItemType="BigShelf.Controllers.FilterViewModel" SelectMethod="GetSearch" UpdateMethod="SetSearch" OnCallingDataMethods="Page_CallingDataMethods" DefaultMode="Edit">
                <EditItemTemplate>
                    <asp:TextBox ID="titleText" runat="server" Text='<%# BindItem.Title %>' placeholder="Search books..." />
                    <asp:Button ID="searchButton" runat="server" Text="Search" CommandName="Update" />
                </EditItemTemplate>
            </asp:FormView>
            <asp:ListView ID="FriendsList" runat="server" ItemType="BigShelf.Controllers.FriendViewModel" SelectMethod="GetFriends" OnCallingDataMethods="Page_CallingDataMethods">
                <LayoutTemplate>
                    <p>
                        <label>Show friends:</label>
                        <span id="itemPlaceHolder" runat="server" />
                        <asp:Button ID="friendButton" runat="server" Text="Filter" />
                    </p>
                </LayoutTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="friendCheck" runat="server" Checked='<%# Item.Checked %>' CssClass="friend" Text='<%#: Item.Name %>' value='<%# Item.Id %>' OnCheckedChanged="friendCheck_CheckedChanged" />
                </ItemTemplate>
            </asp:ListView>
        </div>
    </ContentTemplate>
    <Triggers>
        <nav:NavigationDataTrigger Key="filter" />
        <nav:NavigationDataTrigger Key="sort" />
    </Triggers>
</asp:UpdatePanel>