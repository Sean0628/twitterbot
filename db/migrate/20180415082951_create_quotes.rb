class CreateQuotes < ActiveRecord::Migration[5.1]
  def change
    create_table :quotes do |t|
      t.string :body, null: false
      t.string :author, null: false

      t.timestamps
    end
  end
end
