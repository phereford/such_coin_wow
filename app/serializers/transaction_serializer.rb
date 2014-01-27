class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :address, :amount, :transaction_id, :category, :account, :occurred_at
end
