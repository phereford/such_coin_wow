require 'spec_helper'

describe TransactionsController do
  before(:each) do
    sign_in
  end

  describe 'GET index' do
    it 'assigns @transactions' do
      transaction = create(:transaction)
      get :index

      expect(assigns(:transactions)).to include transaction
    end

    it 'renders the index template' do
      get :index

      expect(:response).to render_template('index')
    end
  end

  describe 'GET show' do
    it 'assigns @transaction' do
      transaction = create(:transaction)
      get :show, { id: transaction.id }

      expect(assigns(:transaction)).to eql transaction
    end

    it 'renders the show template' do
      transaction = create(:transaction)
      get :show, { id: transaction.id }

      expect(:response).to render_template('show')
    end
  end
end
