class CreateParties < ActiveRecord::Migration
  def change
    create_table(:parties) do |t|
      t.text :name

      t.timestamps
    end
  end
end
