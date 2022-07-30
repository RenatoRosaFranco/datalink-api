# frozen_string_literal: true

class AddColumnSlugAndShortLinkToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :slug, :string
    add_column :places, :short_link, :string
  end
end
