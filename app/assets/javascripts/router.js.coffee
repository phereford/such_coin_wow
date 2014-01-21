App.Router.map ->
  @route "dashboard"
  @route "login"
  @route "home"

  @resource "coins"

  @resource "coin", { path: "coin/:coin_id" }, ->
    @route "edit", { path: "edit" }
    @route "sync", { path: "sync" }


  @resource "transactions"
  @resource "transaction", { path: "transaction/:transaction_id" }
