class CertificatesController < ApplicationController

  before_action :set_certificate
  before_action :set_instance

  def sell
    if @instance.stock_rounds == 1
      flash[:error] = "Can't sell in the first stock round"
    else
      flash[:notice] = "Selling Cert #{params[:id]}"
      @company.remember_round_value!
      @certificate.sell!
    end
    redirect_to @instance
  end

private

  def set_certificate
    @certificate = Certificate.find(params[:id])
  end

  def set_instance
    @instance = Instance.find(params[:instance_id])
  end

end
