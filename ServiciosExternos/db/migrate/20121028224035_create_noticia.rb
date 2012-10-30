class CreateNoticia < ActiveRecord::Migration
  def change
    create_table :noticia do |t|
      t.string :link

      t.timestamps
    end
  end
end
