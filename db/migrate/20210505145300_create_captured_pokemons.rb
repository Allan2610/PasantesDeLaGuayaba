class CreateCapturedPokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :captured_pokemons do |t|
      t.string :api_version
      t.string :name
      t.string :first_slot
      t.string :second_slot
      t.string :img_url
    end
  end
end
