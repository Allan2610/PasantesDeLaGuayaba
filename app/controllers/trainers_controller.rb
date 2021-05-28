class TrainersController < ApplicationController
    def index
      @trainers = Trainer.all
    end

    def show

    end
    def new
      @trainer = Trainer.new
    end

    def create
      @new_trainer = Trainer.new(trainers_params)

      if @new_trainer.save
        respond_to do |format|
          format.html{redirect_to trainers_path}
        end
      else
        redirect_to trainers_path
      end
    end

    private
    def trainers_params
      params.require(:trainer).permit(:nombre, :apellido)
    end

    def crear_entrenador(nombre, apellido)
        conn = PG.connect(:host => 'localhost',:port => 5432, :dbname => 'myapp_test',:user => 'rails_dev', :password => 'aqwe123')
        conn.prepare('statement1', 'insert into entrenadores_pokemon
                                    (name, apellido, cantidad_pokemons)
                                    values ($1, $2, $3)')
        conn.exec_prepared('statement1', [nombre, apellido, "-"])
    end
end
