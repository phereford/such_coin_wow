class CoinsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [ :sync, :destroy ]

  def index
    @coins = Coin.page(params[:page])
  end

  def show
    @coin = Coin.find(params[:id])
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
    if SyncTransaction.delay.new(@coin)
      flash[:success] = "#{@coin.ticker} sync processing."
    end
    redirect_to :back
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
