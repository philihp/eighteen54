class CertificatesController < ApplicationController

  before_action :set_certificate
  before_action :set_instance

  def sell
    flash[:notice] = "Selling Cert #{params[:id]}"
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
