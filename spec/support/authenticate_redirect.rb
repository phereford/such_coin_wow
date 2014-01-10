shared_examples_for 'Authenticate Redirect' do
  scenario 'When I am not signed in, I get redirected to the sign in page' do
    visit dashboard_path
    page.should have_css('input#user_email')
    page.should have_content('Forgot your password?')
  end
end
