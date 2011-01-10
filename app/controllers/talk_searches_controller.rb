class TalkSearchesController < ApplicationController
  
  def new
  end
  
  def create
    # @search = Sunspot.search Talk do
    #   keywords params[:search] do
    #   end
    # end
    
    @search = Talk.search(params[:search])
    
    puts "**********"
    puts @search.hits
    # @search.each_hit_with_result do |hit, talk|
    #   puts "hit #{hit} - #{talk.title}"
    # end
    puts "**********"
    @talks = @search.results
    respond_to do |format|
      format.js {}
    end
  end
  
end