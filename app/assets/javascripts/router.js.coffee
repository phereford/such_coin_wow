App.Router.map ->
  @route "dashboard"
  @route "login"
  @route "home"

  @resource "coins"

  @resource "coin", { path: "coin/:coin_id" }
    
  @resource "transactions", { path: "transactions" }
  @resource "transaction", { path: "transaction/:transaction_id" }
