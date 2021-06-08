module Admin
  class InvoicesController < ApplicationController
    before_action :set_invoice, only: [:show, :edit, :update, :destroy]
    before_action :set_form_url, only: [:edit, :new]
    before_action :set_searcher_url, only: [:index, :white_list]
  
    # GET /invoices
    # GET /invoices.json
    def index
      @invoices = params[:query] ? Invoice.search_by_params(params[:query]) : Invoice.all
    end

    def white_list
      @invoices = params[:query] ? Invoice.search_by_params(params[:query]).select { |w| w.validation_status == 'contabilized' } : Invoice.where(validation_status: :contabilized)
      @selected_invoices = if params[:invoice_ids]
        @invoices.where(id: params[:invoice_ids])
      else
        Invoice.none # check none the checkboxes by default
        # or use @invoices for the opposite
      end
    end

    def download_list
      request.format = 'xlsx'
      @invoices = params[:invoice_ids] ? Invoice.where(id: params[:invoice_ids]) : Invoice.all

      respond_to do |format|
        format.xlsx { render xlsx: "download_list" }
      end
    rescue StandardError => e
      Rails.logger.info { "===== ERROR ======" }
      Rails.logger.info { e.message }
      Rails.logger.info { "===== ERROR ======" }
      redirect_back fallback_location: root_path, alert: 'No se pudo descargar la información'
    end
  
    # GET /invoices/1
    # GET /invoices/1.json
    def show
    end
  
    # GET /invoices/new
    def new
      @invoice = Invoice.new
    end
  
    # GET /invoices/1/edit
    def edit
    end
  
    # POST /invoices
    # POST /invoices.json
    def create
      @invoice = Invoice.new(invoice_params)
  
      respond_to do |format|
        if @invoice.save
          format.html { redirect_to admin_invoice_path(@invoice), notice: 'Invoice was successfully created.' }
          format.json { render :show, status: :created, location: @invoice }
        else
          format.html { render :new }
          format.json { render json: @invoice.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /invoices/1
    # PATCH/PUT /invoices/1.json
    def update
      respond_to do |format|
        if @invoice.update(invoice_params)
          format.html { redirect_to admin_invoice_path(@invoice), notice: 'Invoice was successfully updated.' }
          format.json { render :show, status: :ok, location: @invoice }
        else
          format.html { render :edit }
          format.json { render json: @invoice.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /invoices/1
    # DELETE /invoices/1.json
    def destroy
      @invoice.destroy
      respond_to do |format|
        format.html { redirect_to admin_invoices_path, notice: 'Invoice was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_invoice
        @invoice = Invoice.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def invoice_params
        params.require(:invoice).permit(:provider_name, :rut, :folio, :amount, :issue_date, :expire_date, :validation_status, :user_name)
      end

      def set_form_url
        @form_url = params[:action] == 'new' ? admin_invoices_path : admin_invoice_path(@invoice)
      end
      
      def set_searcher_url
        @searcher_url = params[:action] == 'index' ? admin_invoices_path : white_list_admin_invoices_path
      end
  end
end
