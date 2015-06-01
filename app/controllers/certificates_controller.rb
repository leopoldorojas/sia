class CertificatesController < ApplicationController
  before_action :set_certificate, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @certificates = Certificate.all
    respond_with(@certificates)
  end

  def show_original
    respond_with(@certificate)
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "file_name",
                template: 'certificates/show.html.erb',
                disposition: 'attachment',
                layout: 'certificate',
                encoding: "UTF-8"
      end
    end
  end

  def new
    @certificate = Certificate.new certificate_date: Time.zone.now
    respond_with(@certificate)
  end

  def edit
  end

  def create
    @certificate = Certificate.new(certificate_params)
    flash[:notice] = t('certificate.created') if @certificate.save
    respond_with(@certificate) do |format|
      format.html { redirect_to certificate_path(@certificate, format: :pdf) }
    end
  end

  def update
    flash[:notice] = t('certificate.updated') if @certificate.update(certificate_params)
    respond_with(@certificate)
  end

  def destroy
    @certificate.destroy
    respond_with(@certificate)
  end

  private
    def set_certificate
      @certificate = Certificate.find(params[:id])
    end

    def certificate_params
      params.require(:certificate).permit(:identifier, :shares_info, :share_holder_id, :certificate_date)
    end
end
