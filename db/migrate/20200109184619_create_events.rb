class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.datetime :time_of_event
      t.string :period

      t.timestamps
    end
  end
end
