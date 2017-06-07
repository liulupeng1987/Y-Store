class Account::ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
      @products = current_user.favorite_products
      # 商品類型 / 品牌
      @category_groups = CategoryGroup.published
    end

    # 從願望清單上刪除該商品
    def quit_to_favorite
      @product = Product.find(params[:id])
      if current_user.has_favorites?(@product)
        current_user.quit_to_favorite!(@product)
      end

      redirect_to :back
    end

    # 移動至購物車
    def add_to_cart
      @product = Product.find(params[:id])
      @quantity = 1

      if !current_cart.products.include?(@product)
        current_cart.add_product_to_cart(@product,@quantity)
        current_user.remove_from_wish_list!(@product)
        flash[:notice] = t('message-add-to-cart-success')
      else
        flash[:warning] = t('message-already-added')
      end

      redirect_to :back
    end


end
