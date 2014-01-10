require 'spec_helper'

feature 'I see a list of transactions' do
  it_behaves_like 'Signed Out Redirect', '/transasctions'
end
