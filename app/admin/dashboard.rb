ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    

    # Here is an example of a simple dashboard with columns and panels.
    
    columns do
      column do
        panel "Recent Entries" do
          ul do
            Entry.all.joins(:user, :occurrence).limit(5).map do |entry|
              li link_to(entry.user.full_name + " - " + entry.occurrence.name, admin_entry_path(entry))
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content
end
