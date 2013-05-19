class CreateBallotResultTables < ActiveRecord::Migration
  def change
    create_table(:elections) do |t|
      t.text :name
      t.date :date
    end

    create_table(:ballots) do |t|
      t.references :state
      t.references :election
    end

    create_table(:tickets) do |t|
      t.references :ballot
      t.text :position
    end

    create_table(:ballot_positions) do |t|
      t.references :ticket
      t.references :candidate
      t.integer :position
    end

    create_table(:ordinal_preferences) do |t|
      t.references :ballot_position
      t.integer :ordinal
      t.integer :votes

      t.timestamps
    end
  end
end
