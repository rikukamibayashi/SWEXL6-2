class CartitemsController < ApplicationController
    def new
        @cartitem = Cartitem.new
    end
    
    def create
        logger.debug "---------------"
        
        @cart = current_cart
        cart = Cart.find_by(params[:cart_id])
        @cartitem = @cart.cartitems.build(cart: cart)
        
        # @cartitem = CartItem.new(qty: params[:cart_item][:qty], 
            # product_id: params[:product_id], cart_id: params[:cart_id])
        if @cartitem.save
            flash[:notice] = 'カートに商品を追加しました'
             redirect_to '/carts/show'
        else
            render 'new' 
        end
    end
    
    def destroy
        cartitem = Cartitem.find(params[:id])
        if cartitem.destroy
            flash[:notice] = 'カートから商品を削除しました'
        end
        redirect_to cartitems_path
    end
end