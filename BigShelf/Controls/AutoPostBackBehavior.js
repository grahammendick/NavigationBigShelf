Type.registerNamespace('BigShelf');

BigShelf.AutoPostBackBehavior = function (element) {
    BigShelf.AutoPostBackBehavior.initializeBase(this, [element]);
    this._uniqueID = null;
    this._trigger = null;
    this._throttle = null;
    this._timer = null;
    this._triggerHandler = Function.createDelegate(this, this._onTrigger);
}

BigShelf.AutoPostBackBehavior.prototype = {
    initialize: function () {
        BigShelf.AutoPostBackBehavior.callBaseMethod(this, 'initialize');
        $addHandler(this.get_element(), this.get_trigger(), this._triggerHandler);
    },

    dispose: function () {
        $removeHandler(this.get_element(), this.get_trigger(), this._triggerHandler);
        this._stopTimer();
        BigShelf.AutoPostBackBehavior.callBaseMethod(this, 'dispose');
    },

    get_uniqueID: function () {
        return this._uniqueID;
    },

    set_uniqueID: function (value) {
        this._uniqueID = value;
    },

    get_trigger: function () {
        return this._trigger;
    },

    set_throttle: function (value) {
        this._throttle = value;
    },

    get_throttle: function () {
        return this._throttle;
    },

    set_trigger: function (value) {
        this._trigger = value;
    },

    _get_timer: function () {
        return this._timer;
    },

    _set_timer: function (value) {
        this._timer = value;
    },

    _startTimer : function(uniqueId){
        this._timer = window.setTimeout(function () { __doPostBack(uniqueId, '') }, this.get_throttle())
    },

    _stopTimer : function(){
        window.clearTimeout(this._timer);
    },

    _onTrigger: function (e) {
        this._stopTimer();
        this._startTimer(this.get_uniqueID());
    }
}

BigShelf.AutoPostBackBehavior.registerClass('BigShelf.AutoPostBackBehavior', Sys.UI.Behavior);

if (typeof (Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();