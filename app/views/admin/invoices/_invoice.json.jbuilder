json.extract! invoice, :id, :provider_name, :rut, :folio, :amount, :issue_date, :expire_date, :validation_status, :user_name, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
