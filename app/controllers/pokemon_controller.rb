class PokemonController < ApplicationController
  before_action :set_pokemon, only: :index

    def index

    end

    def new
        @pokemon = Pokemon.new
    end

    def create
      @new_pokemon = Pokemon.new(pokemon_params)

      if @new_pokemon.save
          respond_to do |format|
          format.html{redirect_to pokemon_index_path}
        end
      else
        redirect_to pokemon_index_path
      end
    end

    def show
      @pokemon_capturado = PokemonService.new().get_info_pokemon(params['url'])
      @info_pokemon = JSON.parse @pokemon_capturado

      @version_API = params['url']

      @nombre = @info_pokemon['forms'][0]['name']
      @tipo_primario = @info_pokemon['types'][0]['type']['name']


      # condicional de existencia
      tipo_secundario = @info_pokemon['types'][1]
      if tipo_secundario.present?
        @tipo_secundario = tipo_secundario['type']['name']
      end
      PokemonController.new().insertar_pokemon(@version_API, @nombre, @tipo_primario, @tipo_secundario )    
    end





    def set_pokemon
        @pokemon_list = PokemonService.new().get_all
    end

    def insertar_pokemon(version_API, nombre, tipo_primario, tipo_secundario)
      conn = PG.connect(:host => 'localhost',:port => 5432, :dbname => 'myapp__development',:user => 'rails_dev', :password => 'aqwe123')
      conn.prepare('statement1', 'insert into captured_pokemons
                                  (api_version, name, first_slot, second_slot, img_url)
                                  values ($1, $2, $3, $4, $5)')
      conn.exec_prepared('statement1', [version_API, nombre, tipo_primario, tipo_secundario, "-"])
    end
    private
    def pokemon_params
      params.require(:pokemon).permit(:version_API, :nombre, :tipo_primario, :tipo_secundario )
    end
  end
