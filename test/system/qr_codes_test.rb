require "application_system_test_case"

class QRCodesTest < ApplicationSystemTestCase
  setup do
    @qr_code = qr_codes(:one)
  end

  test "visiting the index" do
    visit qr_codes_url
    assert_selector "h1", text: "QR Codes"
  end

  test "creating a QR code" do
    visit qr_codes_url
    click_on "New QR Code"

    click_on "Create QR code"

    assert_text "QR code was successfully created"
    click_on "Back"
  end

  test "updating a QR code" do
    visit qr_codes_url
    click_on "Edit", match: :first

    click_on "Update QR code"

    assert_text "QR code was successfully updated"
    click_on "Back"
  end

  test "destroying a QR code" do
    visit qr_codes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "QR code was successfully destroyed"
  end
end
