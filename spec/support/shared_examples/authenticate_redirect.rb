require 'spec_helper'

shared_examples_for 'Signed Out Redirect' do
  scenario 'I should be redirected to the sign_in page' do
    visit dashboard_path

    page.should have_css('input#user_email')
    page.should have_content('Forgot your password?')
  end
end
