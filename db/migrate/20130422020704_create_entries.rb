class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
    	t.text	:term
    	t.text	:definition
    	t.text 	:translation
      t.timestamps
    end
  end
end
