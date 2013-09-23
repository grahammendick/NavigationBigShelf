$(function () {
    $("html").addClass('js')
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
        $(".ratings input[value!='0']").rating({ required: true });
        $(".ratings input[value='0']").hide();
    });
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(function (sender, args) {
        $(args.get_postBackElement()).parents('.coverCol, .details').siblings('.coverCol, .details').andSelf().addClass('updating');
    });
});