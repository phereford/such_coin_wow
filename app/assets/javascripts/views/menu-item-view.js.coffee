App.MenuItemView = Ember.View.extend
  templateName: "menu_item"
  tagName: "a"
  classNames: ["btn"]
  attributeBindings: ["href", "hidden"]
  hidden: "hidden"
