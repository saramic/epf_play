class CreateSource < ActiveRecord::Migration
  def change
    create_table(:sources) do |t|
      t.text :title
      t.text :url
      t.text :parent_url
      t.text :description
      t.text :asset
      t.text :asset_hash

      t.timestamps
    end
  end
end
