class AddFieldsToParty < ActiveRecord::Migration
  def change
    add_column :parties, :home_page, :text
    add_column :parties, :policies,  :text
    add_column :parties, :twitter,   :text
    add_column :parties, :facebook,  :text
  end
end
