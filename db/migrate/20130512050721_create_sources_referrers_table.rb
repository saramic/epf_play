class CreateSourcesReferrersTable < ActiveRecord::Migration
  def change
    create_table :sources_referrers, :id => false do |t|
      t.references :source
      #t.integer :referrer_id
      #t.string :referrer_type
      t.string :referrer_field_name
      t.references :referrer, :polymorphic => true
    end

    add_index :sources_referrers, [:source_id, :referrer_id]
    add_index :sources_referrers, [:referrer_id, :source_id]
  end
end
