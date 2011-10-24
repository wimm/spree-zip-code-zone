Deface::Override.new(:virtual_path => "admin/configurations/index",
                     :name => "add_zip_zones_to_admin_menu",
                     :insert_bottom => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
                     :text => "<tr><td><%= link_to t('zip_code_ranges'), admin_zip_code_ranges_path %></td><td><%= t('zip_code_ranges_description') %></td></tr>",
                     :disabled => false)
