module TransactionsHelper
  def colorize_amount(transaction)
    content_tag(
      :span,
      transaction.amount,
      class: transaction.category == 'receive' ? 'green' : 'red'
    )
  end
end
