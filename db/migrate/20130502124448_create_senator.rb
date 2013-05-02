class CreateSenator < ActiveRecord::Migration
  def change
    create_table(:senators) do |t|
      t.string :name
      t.string :position
      t.string :source_url
      t.string :source_img_url

      t.timestamps
    end
  end
end
