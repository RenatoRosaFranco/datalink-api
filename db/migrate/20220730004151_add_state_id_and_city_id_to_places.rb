# frozen_string_literal: true

class AddStateIdAndCityIdToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_reference :places, :state, foreign_key: true
    add_reference :places, :city, foreign_key: true
  end
end
