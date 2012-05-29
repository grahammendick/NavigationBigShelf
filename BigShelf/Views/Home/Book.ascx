<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Book.ascx.cs" Inherits="BigShelf.Views.Home.Book" %>
<%@ Register Assembly="BigShelf" Namespace="BigShelf.Controls" TagPrefix="big" %>
<asp:UpdatePanel ID="Panel" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <asp:FormView ID="BookForm" runat="server" ItemType="BigShelf.Controllers.BookViewModel" DataKeyNames="Id" SelectMethod="GetBook" UpdateMethod="UpdateBook" DeleteMethod="RateBook" DefaultMode="Edit" OnCallingDataMethods="Page_CallingDataMethods">
            <EditItemTemplate>
                <div class="coverCol">
                    <img id="bookImage" runat="server" src='<%# Item.CoverImageUrl %>' alt='<%# Item.Title %>' />
                    <asp:Button ID="flagButton" runat="server" Text='<%# Item.StatusText %>' Enabled='<%# Item.CanFlagToRead %>' CssClass="button flagToRead" CommandName="Update" />
                </div>
                <div class="details">
                    <h3 class="title"><%#: Item.Title %></h3>
                    <div class="author">by <span><%#: Item.Author %></span></div>
                    <div>
                        <asp:RadioButtonList ID="ratingList" runat="server" RepeatLayout="OrderedList" SelectedValue='<%# BindItem.Rating %>' CssClass="ratings" DataValueField="Key" DataTextField="Value" SelectMethod="GetRatings" OnCallingDataMethods="Page_CallingDataMethods"/>
                        <big:AutoPostBackExtender ID="ratingExtender" runat="server" TargetControlID="ratingList" Trigger="click" CommandName="Delete" ClientIDMode="AutoID" />
                        <asp:Button ID="ratingButton" runat="server" Text="Rate" CommandName="Delete" />
                    </div>
                </div>
            </EditItemTemplate>
        </asp:FormView>
    </ContentTemplate>
</asp:UpdatePanel>