class AddressesController < ApplicationController

  layout false

  before_action :auth_user

  def index
    @addresses = current_user.addresses.order("id desc")
  end

  def set_default_address
  end
  
end
