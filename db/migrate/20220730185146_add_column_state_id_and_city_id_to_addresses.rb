# frozen_string_literal: true

class AddColumnStateIdAndCityIdToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :state, foreign_key: true
    add_reference :addresses, :city, foreign_key: true
  end
end
