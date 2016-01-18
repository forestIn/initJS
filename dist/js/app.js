(function() {
  var AppState, Controller, Error, Family, Start, Success, Views, controller;

  AppState = {
    username: ""
  };

  Family = ["Марина", "София", "Златояр"];

  Views = {};

  Controller = Backbone.Router.extend({
    routes: {
      "": "start",
      "!/": "start",
      "!/success": "success",
      "!/error": "error"
    },
    start: function() {
      if (Views.start != null) {
        return Views.start.render();
      }
    },
    success: function() {
      if (Views.success != null) {
        return Views.success.render();
      }
    },
    error: function() {
      if (Views.error != null) {
        return Views.error.render();
      }
    }
  });

  controller = new Controller();

  Backbone.history.start();

  Start = Backbone.View.extend({
    el: '#block',
    template: _.template($('#start').html()),
    events: {
      "click button:button": "check"
    },
    check: function() {
      AppState.username = this.$el.find("input:text").val();
      if (_.detect(Family, function(elem) {
        return elem === AppState.username;
      })) {
        return controller.navigate("!/success", true);
      } else {
        return controller.navigate("!/error", true);
      }
    },
    render: function() {
      return this.$el.html(this.template());
    }
  });

  Success = Backbone.View.extend({
    el: '#block',
    template: _.template($('#success').html()),
    render: function() {
      return this.$el.html(this.template(AppState));
    }
  });

  Error = Backbone.View.extend({
    el: '#block',
    template: _.template($('#error').html()),
    render: function() {
      return this.$el.html(this.template(AppState));
    }
  });

  Views = {
    start: new Start(),
    success: new Success(),
    error: new Error()
  };

}).call(this);
