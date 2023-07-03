class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
    @address = @customer.addresses
    @addresses = Address.new
  end

  def create
    @addresses = Address.new(address_params)
    @addresses.customer_id = current_customer.id
    if @addresses.save
      redirect_to addresses_path
    else
      @address = Address.all
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      @address = Address.all
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    @address = Address.all
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
