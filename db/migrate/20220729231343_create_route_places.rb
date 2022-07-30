# frozen_string_literal: true

class CreateRoutePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table   :route_places do |t|
      t.references :route, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
