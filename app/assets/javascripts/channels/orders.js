var Bookstore = typeof Bookstore === "undefined" ? {} : Bookstore;
// aqui que é o handle do ActionCable, o resto é tudo firula. ;-)
Bookstore.Orders = function(orderId) {
  this.orderId = orderId;
  this.subscribe = function() {
    App.orders = App.cable.subscriptions.create({channel: 'OrdersChannel',id: this.orderId}, {
      received: function(data) {
          Bookstore.Orders.autohide_msg(data.msg);
      }
    }); 
  };
};
// cria a mensagem
Bookstore.Orders.autohide_msg = function(msg) {
  var div    = Bookstore.Orders.autohide_div();
  var button = Bookstore.Orders.autohide_button();
  Bookstore.Orders.autohide_action(div);
  div.append(msg);
  div.append(button);
  $("body").prepend(div);
};

// cria a ação de auto esconder
Bookstore.Orders.autohide_action = function(div) {
  window.setTimeout(function() {
     div.fadeTo(500, 0).slideUp(500, function(){
        div.remove();
     });
}, 3000); };


// cria o botão para fechar
Bookstore.Orders.autohide_button = function() {
  var button = $("<button/>");
  button.addClass("close");
  button.append("&times;");
  button.click(function(evt) {
     $(evt.target).parent().remove();
  });
  return button;
}
//criaadiv
Bookstore.Orders.autohide_div = function() {
  var div = $("<div/>");
  div.addClass("alert");
  div.attr("role", "alert");
  return div;
};

// retorna o id da URL
Bookstore.Orders.idFromURL = function() {
  var id = parseInt(window.location.href.match(/(\/)(\d+)$/)[2]);
  return id;
}