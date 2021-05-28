class CreateTrainers < ActiveRecord::Migration[5.2]
  create_table :trainers do |t|
    t.string :nombre
    t.string :apellido
    t.integer :cantidad_pokemons, default: 0
  end
end
