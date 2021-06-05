class Invoice < ApplicationRecord
  enum validation_status: { contabilized: 0, not_contabilized: 1 }
end
