<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Paging.ascx.cs" Inherits="BigShelf.Views.Home.Paging" %>
<%@ Register Assembly="Navigation" Namespace="Navigation" TagPrefix="nav" %>
Results:
<asp:UpdatePanel ID="PagingPanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false" RenderMode="Inline">
    <ContentTemplate>
        <asp:ListView ID="PagingList" runat="server" ItemType="BigShelf.Controllers.PagingViewModel" SelectMethod="GetPages" OnCallingDataMethods="Page_CallingDataMethods">
            <LayoutTemplate>
                <ul class="paging"><li id="itemPlaceHolder" runat="server" /></ul>
            </LayoutTemplate>
            <ItemTemplate>
                <li>
                    <nav:NavigationHyperLink ID="pageLink" runat="server" ToData='<%# new NavigationData(){{ "page" , Item.Index }} %>' Text='<%#: Item.GroupText %>' Direction="Refresh" IncludeCurrentData="true" DisableInert="true" InertCssClass="selected" PostBack="true" ClientIDMode="AutoID" />
                </li>
            </ItemTemplate>
            <EmptyDataTemplate>
                <strong>None</strong>
            </EmptyDataTemplate>
        </asp:ListView>
    </ContentTemplate>
    <Triggers>
        <nav:NavigationDataTrigger Key="filter" />
        <nav:NavigationDataTrigger Key="friends" />
        <nav:NavigationDataTrigger Key="title" />
        <nav:NavigationDataTrigger Key="page" />
        <nav:NavigationDataTrigger Key="pageSize" />
    </Triggers>
</asp:UpdatePanel>
