require 'spec_helper'

describe SidebarHelper do
  context 'sidebar' do
    it 'creates a set number of list items based on SIDEBAR constant' do
      expect(helper.sidebar).to include
        %{<li>
            <a href="/dashbaord">
              <i class="icon-dashboard"></i>
              <span>Dashboard</span>
            </a>
        </li>}
    end
  end

  context 'link_list' do
    it 'creates anchor tag (icon and text) linking to an admin index' do
      expect(helper.link_list('Dashboard', 'icon-dashboard', :dashboard)).to include 
        %{<a href="/">
            <i class='icon-dashboard'></i>
            <span>Dashboard</span>
        </a>}
    end
  end
end
