# frozen_string_literal: true

class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table   :galleries do |t|
      t.string     :photo
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
