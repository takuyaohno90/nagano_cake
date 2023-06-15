class Public::CustomersController < ApplicationController
  def show

  end

  def edit
    @customer = current_customer
  end

  def update
    customer = current_customer
    customer.update(customer_params)
    redirect_to customers_mypage_path
  end

  def confirm_withdraw
  end

  def withdraw
    current_customer.update(is_deleted: 'true')
    reset_session
    redirect_to root_path, notice: 'Successfully withdraw from Ecommerce'
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end