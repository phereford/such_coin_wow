require 'spec_helper'

shared_examples_for 'Signed Out Redirect' do |path|
  scenario 'I should be redirected to the sign_in page' do
    visit path
    page.should have_css('#user_email')
    page.should have_content('Forgot your password?')
  end
end
