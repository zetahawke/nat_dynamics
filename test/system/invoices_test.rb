require "application_system_test_case"

class InvoicesTest < ApplicationSystemTestCase
  setup do
    @invoice = invoices(:one)
  end

  test "visiting the index" do
    visit invoices_url
    assert_selector "h1", text: "Invoices"
  end

  test "creating a Invoice" do
    visit invoices_url
    click_on "New Invoice"

    fill_in "Amount", with: @invoice.amount
    fill_in "Expire date", with: @invoice.expire_date
    fill_in "Folio", with: @invoice.folio
    fill_in "Issue date", with: @invoice.issue_date
    fill_in "Provider name", with: @invoice.provider_name
    fill_in "Rut", with: @invoice.rut
    fill_in "User name", with: @invoice.user_name
    fill_in "Validation status", with: @invoice.validation_status
    click_on "Create Invoice"

    assert_text "Invoice was successfully created"
    click_on "Back"
  end

  test "updating a Invoice" do
    visit invoices_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @invoice.amount
    fill_in "Expire date", with: @invoice.expire_date
    fill_in "Folio", with: @invoice.folio
    fill_in "Issue date", with: @invoice.issue_date
    fill_in "Provider name", with: @invoice.provider_name
    fill_in "Rut", with: @invoice.rut
    fill_in "User name", with: @invoice.user_name
    fill_in "Validation status", with: @invoice.validation_status
    click_on "Update Invoice"

    assert_text "Invoice was successfully updated"
    click_on "Back"
  end

  test "destroying a Invoice" do
    visit invoices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Invoice was successfully destroyed"
  end
end
