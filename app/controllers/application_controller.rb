require "pry"
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/recipes" do
    @recipes = Recipe.all
    erb :recipes
  end

  post "/recipes" do
    @recipe = Recipe.create(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time])

    redirect to "recipes/#{@recipe.id}"
  end

  get "/recipes/new" do
    erb :recipe_new
  end

  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :recipe_view
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])
    erb :recipe_edit
  end

  delete "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end

  patch "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    @recipe.update(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time])

    redirect to "/recipes/#{@recipe.id}"
  end

end
