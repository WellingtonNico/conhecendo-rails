var Bookstore = typeof Bookstore === "undefined" ? {} : Bookstore;
Bookstore.Cart = function () {
    this.fire = function () {
        $('.cart-qty').on('input', function (evt) {
            var target = $(evt.target);
            var id = target.attr('data-id');
            var qty = parseInt(target.val());
            if (isNaN(qty)) {
                return false;
            }
            $.ajax({
                url: "/carrinho/alterar_item/" + id,
                method: 'PATCH',
                dataType: 'script',
                data: { qty: qty }
            });
        });

    };
};