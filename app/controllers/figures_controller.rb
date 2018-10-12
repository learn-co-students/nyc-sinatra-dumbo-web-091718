require 'pry'

class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params[:landmark][:name].nil?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    if !params[:title][:name].nil?
      @figure.titles << Title.create(params[:title])
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    #binding.pry
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do

    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    # if !params[:landmark][:name].nil?
      @landmark = Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"], figure_id: @figure.id)
      # @figure.landmark_id = @landmark.id
    # end
    # if !params[:title][:name].nil?
      @title = Title.create(name: params["title"]["name"])
      # @figure.title_id = @title.id
    # end
    FigureTitle.create(figure_id: @figure.id, title_id: @title.id)

    # @figure.title_id = params[:figure][:title_id]
    # @figure.landmark_id = params[:figure][:landmark_id]
    @figure.save
    # binding.pry
    redirect to "/figures/#{@figure.id}"
  end

end
