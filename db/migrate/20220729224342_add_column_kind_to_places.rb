# frozen_string_literal: true

class AddColumnKindToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :kind, :integer, default: 0
  end
end
