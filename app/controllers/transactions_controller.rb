class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.page(params[:page])
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
end
