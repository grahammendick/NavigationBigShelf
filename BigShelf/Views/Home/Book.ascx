<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Book.ascx.cs" Inherits="BigShelf.Views.Home.Book" %>
<asp:FormView ID="BookForm" runat="server" ItemType="BigShelf.Controllers.BookViewModel" DataKeyNames="Id" SelectMethod="GetBook" UpdateMethod="UpdateBook" DefaultMode="Edit" OnCallingDataMethods="Page_CallingDataMethods">
    <EditItemTemplate>
        <div class="coverCol">
            <img id="bookImage" runat="server" src='<%# Item.CoverImageUrl %>' alt='<%# Item.Title %>' />
            <asp:Button ID="flagButton" runat="server" Text='<%# Item.StatusText %>' Enabled='<%# Item.CanFlagToRead %>' CssClass="flagToRead" CommandName="Update" />
        </div>
        <div class="details">
            <h3 class="title"><%#: Item.Title %></h3>
            <div class="author">by <span><%#: Item.Author %></span></div>
        </div>
    </EditItemTemplate>
</asp:FormView>