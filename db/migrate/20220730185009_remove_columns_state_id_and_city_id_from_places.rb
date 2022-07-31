# frozen_string_literal: true

class RemoveColumnsStateIdAndCityIdFromPlaces < ActiveRecord::Migration[5.2]
  def change
    remove_reference :places, :state, foreign_key: true
    remove_reference :places, :city, foreign_key: true
  end
end
