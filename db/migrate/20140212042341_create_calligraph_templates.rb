class CreateCalligraphTemplates < ActiveRecord::Migration
  def change
    create_table :calligraph_templates do |t|
      t.string :title
      t.text :markup

      t.timestamps
    end
  end
end
