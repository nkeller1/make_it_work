class ContestantsController < ApplicationController
  def index
    @contestants = Contestant.all
  end

  def create
    require "pry"; binding.pry
    project = Project.find(params[:id])
    # song = artist.songs.create!(song_params)
    redirect_to "/projects/#{project.id}"
  end
end
