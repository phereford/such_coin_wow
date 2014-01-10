require 'spec_helper'

feature 'I see a list of coins' do
  it_behaves_like 'Signed Out Redirect', '/coins'
end
