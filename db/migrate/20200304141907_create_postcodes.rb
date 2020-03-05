# frozen_string_literal: true

class CreatePostcodes < ActiveRecord::Migration[6.0]
  def change
    create_table :postcodes do |t|
      t.string :postcode, null: false, index: { unique: true }
      t.timestamps null: false
    end
  end
end
