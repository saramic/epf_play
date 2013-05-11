class CreateStates < ActiveRecord::Migration
  def change
    create_table(:states) do |t|
      t.text :short_name
    end

    %w(ACT NSW NT QLD SA TAS VIC WA).each do |short_name|
      State.create(short_name: short_name)
    end
  end
end
