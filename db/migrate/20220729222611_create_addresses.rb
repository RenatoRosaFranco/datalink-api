# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table   :addresses do |t|
      t.string     :location
      t.integer    :number
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
