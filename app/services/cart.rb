class Cart
    def initialize
        clear
    end

    def <<(product)
        @items[product.id] += 1
        @items
    end

    def -(product)
        @items.delete(product.id) if @items.key?(product.id)
        @items
    end

    def include?(product)
        @items.key?(product.id)
    end

    def total 
        @items.inject(0) do |memo, item|
            memo += Book.find(item[0]).value * item[1]
            memo
        end
    end

    def clear
        @items = Hash.new(0)
    end

    def items
        @items.map do |id, qty|
            {
                id: id,
                item: Book.find(id),
                qty: qty
            }
        end
    end

    def change(product,qty)
        if qty < 1
            self - product
            return
        end
        @items[product.id] = qty
    end


end