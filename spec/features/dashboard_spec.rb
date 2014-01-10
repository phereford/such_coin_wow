require 'spec_helper'

feature 'Dashbpoard is restricted to signed_in users' do
  it_behaves_like 'Signed Out Redirect', '/dashboard'
end
