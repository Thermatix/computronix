require 'money'
require 'money/bank/google_currency'
require 'json'

module FrontPageHelper

  def nav_button_class tree_level

    "class='nav button nav_#{css_class(tree_level)}'".html_safe
  end

  def css_class tree_level
    return "root" if tree_level == 1
    return "major" if tree_level == 2
    return "minor" if tree_level == 3
  end

  def tree_pos tree_level
    temp = ""
    for i in 2..tree_level do
      temp += "━"
    end
    "╰#{temp}┫"
  end

  def nav_locals
    {categories: Category.roots, tree_level: 0}
  end

  def center_page_locals
    {categories: (@category || Category.roots)}
  end

  def set_visibility category, tree_level
    "setVisibility(nav button nav_#{css_class(tree_level + 1)}, \"block\" )"
  end


end
