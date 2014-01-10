feature 'Visiting the dashboard' do
  context 'being signed out' do
    visit dashboard_path
    page.should have_css('input#user_Email')
    page.should have_content('Forgot your password?')
  end
end
