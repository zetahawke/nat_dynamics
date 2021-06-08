class Invoice < ApplicationRecord
  # acts_as_xlsx

  enum validation_status: { contabilized: 0, not_contabilized: 1 }

  class << self
    def search_by_params(params)
      invoices = Invoice.all
      invoices = invoices.where("LOWER(provider_name) like ?", "%#{params[:provider_name].downcase}%") unless params[:provider_name].blank?
      invoices = invoices.where("LOWER(folio) like ?", "%#{params[:folio].downcase}%") unless params[:folio].blank?
      invoices = invoices.where("LOWER(rut) like ?", "%#{params[:rut].downcase}%") unless params[:rut].blank?
      invoices
    end
  end
end
