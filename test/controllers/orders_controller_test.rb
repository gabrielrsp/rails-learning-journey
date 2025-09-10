require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    # Garante que o carrinho esteja limpo no início de cada teste
    Cart.destroy_all
  end

  test "requires item in cart" do
    # Tenta acessar new_order sem itens no carrinho
    get new_order_url
    assert_redirected_to store_index_path
    assert_equal "Your cart is empty", flash[:notice]
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    # Adiciona um item ao carrinho para permitir criar pedido
    post line_items_url, params: { product_id: products(:ruby).id }

    get new_order_url
    assert_response :success
  end

  test "should create order" do
    # Adiciona item ao carrinho antes de criar pedido
    post line_items_url, params: { product_id: products(:ruby).id }

    assert_difference("Order.count") do
      post orders_url, params: { order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference("Order.count", -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
