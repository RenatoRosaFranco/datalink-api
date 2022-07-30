# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table   :pages do |t|
      t.string     :vpath
      t.text       :about
      t.string     :facebook
      t.string     :instagram
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
