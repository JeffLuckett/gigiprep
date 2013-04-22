class CreateGlossaries < ActiveRecord::Migration
  def change
    create_table :glossaries do |t|

      t.timestamps
    end
  end
end
