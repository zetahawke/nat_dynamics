class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :provider_name
      t.string :rut
      t.string :folio
      t.integer :amount, default: 0
      t.date :issue_date, default: Date.current
      t.date :expire_date, default: Date.current
      t.integer :validation_status, default: 1
      t.string :user_name

      t.timestamps
    end
  end
end
