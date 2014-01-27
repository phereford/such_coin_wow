class CoinsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, only: [ :sync, :destroy ]

  def index
    coins = current_user.coins.order('mined DESC').page(params[:page])
    render json: coins, each_serializer: CoinsSerializer
  end

  def show
    coin = Coin.includes(:transactions).find(params[:id])
    render json: coin, serializer: CoinSerializer
  end

  def new
    @coin = Coin.new
  end

  def create
    @coin = Coin.new(permitted_params)
    if @coin.save
      redirect_to coins_path, success: 'Successfully saved your coin.'
    else
      render :new
    end
  end

  def edit
    @coin = Coin.find(params[:id])
  end

  def update
    @coin = Coin.find(params[:id])
    if @coin.update_attributes(permitted_params)
      flash[:success] = 'Coin Updated.'
      redirect_to coins_path
    else
      render 'edit'
    end
  end

  def destroy
    @coin = Coin.find(params[:id])
    @coin.destroy
    render nothing: true
  end

  def sync
    @coin = Coin.find(params[:id])
    @coin.remove_jobs

    if SyncTransaction.delay(queue: @coin.ticker).new(@coin)
      render json: "Sync for #{@coin.ticker} successfully queued.".to_json
    else
      render json: "There was an error.".to_json
    end
  end

  def daily_summary
    @coin = Coin.find(params[:id])
    render json: @coin.highcharts_array, status: 200, root: false
  end

  private
  def permitted_params
    params.require(:coin).permit(:user_id, :name, :ticker, :mined, cryptsy_market_ids: [:BTC, :LTC, :XPM])
  end
end
