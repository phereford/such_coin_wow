require 'spec_helper'

describe DashboardController, 'GET index' do
  it 'renders the index template' do
    sign_in
    get :index

    expect(:response).to render_template('index')
  end
end
