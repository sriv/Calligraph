class CreateCalligraphMetaTags < ActiveRecord::Migration
  def change
    create_table :calligraph_meta_tags do |t|
      t.string :name
      t.string :value
      t.belongs_to :content

      t.timestamps
    end
  end
end