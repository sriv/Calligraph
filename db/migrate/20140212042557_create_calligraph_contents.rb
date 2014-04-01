class CreateCalligraphContents < ActiveRecord::Migration
  def change
    create_table :calligraph_contents do |t|
      t.string :title
      t.text :data
      t.references :template
	    t.string   :path
	    t.integer  :content_template_id
	    t.string   :content_template_type

      t.timestamps
    end
  end
end
