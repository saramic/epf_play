class CreateCandidate < ActiveRecord::Migration
  def change
    create_table(:candidates) do |t|
      t.text :given_name
      t.text :surname
      t.integer :aec_candidate_id, null: false
      t.references :party, null: false
      t.references :state, null: false

      t.timestamps
    end
  end
end
