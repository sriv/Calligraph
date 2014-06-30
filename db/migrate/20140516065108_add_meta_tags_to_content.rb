class AddMetaTagsToContent < ActiveRecord::Migration
  def change
    add_column Calligraph::Content.table_name, :meta_tags, :hstore, default: {}
  end
end
