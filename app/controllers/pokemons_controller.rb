class PokemonsController < ApplicationController

  def capture
    pokemon = Pokemon.find(params[:id])
    pokemon.update(trainer: current_trainer)
    redirect_to '/'
  end

  def damage
    pokemon = Pokemon.find(params[:id])
    @trainer = pokemon.trainer_id
    pokemon.update(health: pokemon.health - 10)
    if pokemon.health <= 0
      pokemon.destroy
    end
    redirect_to trainer_path(@trainer)
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.create(pokemon_params)
    if @pokemon.save
      @pokemon.update(trainer: current_trainer)
      @pokemon.update(level: 1)
      @pokemon.update(health: 100)
      redirect_to trainer_path(@pokemon.trainer_id)
    else
      flash[:error] = @pokemon.errors.full_messages.to_sentence
      render "new"
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name)
  end

end
