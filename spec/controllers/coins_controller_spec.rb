require 'spec_helper'

describe CoinsController do
  before(:each) do
    user = create(:user)
    sign_in(user)
    @coin = create(:coin, user: user)
  end

  describe 'GET index' do
    it 'assigns @coins' do
      get :index

      expect(assigns(:coins)).to include @coin
    end
  end

  describe 'GET show' do
    it 'assigns @coin' do
      get :show, { id: @coin.id }

      expect(assigns(:coin)).to eql @coin
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'saves the new coin in the database' do
        expect{
          post :create, coin: attributes_with_foreign_keys(:coin)
        }.to change{Coin.count}.by(1)
      end

      it 'redirects to the index path' do
        post :create, coin: attributes_with_foreign_keys(:coin)
        expect(:response).to redirect_to(coins_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new coin in the database' do
        expect{
          post :create, coin: FactoryGirl.attributes_for(:coin, :invalid)
        }.to_not change{Coin.count}.by(1)
      end

      it 'renders the :new template' do
        post :create, coin: FactoryGirl.attributes_for(:coin, :invalid)
        expect(:response).to render_template :new
      end
    end
  end

  describe 'GET new' do
    it 'assigns @coin' do
      get :new

      expect(assigns(:coin)).to be_instance_of Coin
    end
  end

  describe 'GET edit' do
    it 'assigns @coin' do
      get :edit, { id: @coin.id }

      expect(assigns(:coin)).to eql @coin
    end
  end

  describe 'PUT update' do
    it 'assigns @coin' do
      put :update, id: @coin.id, coin: attributes_with_foreign_keys(:coin)

      expect(assigns(:coin)).to eql @coin
    end

    context 'with valid attributes' do
      it 'updates the record' do
        @coin = create(:coin)
        put :update, {id: @coin.id, coin: attributes_with_foreign_keys(:coin, name: 'NEWNNAME') }
        expect(Coin.where(name: 'NEWNNAME').first).to_not be nil
      end

      it 'redirects to the coinds index path' do
        put :update, { id: @coin.id, coin: attributes_with_foreign_keys(:coin, name: 'NEWNNAME') }
        expect(:response).to redirect_to(coins_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the record' do
        expect{
          put :update, { id: @coin.id, coin: { name: nil } }
        }.to_not change{@coin.name}
      end

      it 'renders the edit template' do
        expect(
          put :update, { id: @coin.id, coin: { name: nil } }
        ).to render_template('edit')
      end
    end
  end

  describe 'GET sync' do
    before(:each) do
      request.env['HTTP_REFERER'] = coins_path
    end

    it 'assigns coin' do
      get :sync, id: @coin.id

      expect(assigns(:coin)).to eql @coin
    end

    context 'successfully schedules a sync job' do
      it 'schedules a SyncTransaction delayed job' do
        expect{
          get :sync, id: @coin.id
        }.to change{Delayed::Job.count}.by(1)
      end

      it 'sets the success message' do
        get :sync, id: @coin.id

        (response.body).should eql "Sync for #{@coin.ticker} successfully queued.".to_json
      end
    end
  end

  describe 'DELETE destroy' do
    it 'assigns @coin' do
      get :destroy, id: @coin.id
      expect(assigns(:coin)).to eql @coin
    end

    it 'removes the coin from the database' do
      expect{
        get :destroy, id: @coin.id
      }.to change{Coin.count}.by(-1)
    end
  end

  describe 'daily_summary' do
    it 'assigns @coin' do
      get :daily_summary, id: @coin.id
      expect(assigns(:coin)).to eql @coin
    end

    it 'renders json for highcharts' do
      create(:transaction, coin: @coin, occurred_at: Date.today, amount: 100.0)
      get :daily_summary, id: @coin.id

      expect(response.body).to eql "[[#{Date.today.to_time.to_i*1000},100.0]]"
    end
  end
end
