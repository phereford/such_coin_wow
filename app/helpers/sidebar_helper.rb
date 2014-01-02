module SidebarHelper
  SIDEBAR = {
    'Dashboard' => [ 'fa fa-dashboard', :dashboard ],
    'Coins' => [ 'fa fa-btc', :coins ],
    'Transactions' => [ 'fa fa-ticket', :transactions ]
  }

  def sidebar
    SIDEBAR.map do |title, (icon, path)|
      %{<li>#{link_list(title, icon, path)}</li>}
    end.join('').html_safe
  end

  def link_list(title, icon, path)
    link_to polymorphic_path(path) do
      content_tag(:i, nil, class: icon)
        .concat(content_tag :span, title)
    end
  end
end
