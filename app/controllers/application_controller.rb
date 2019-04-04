class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  ## read
  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end

  ## start a new
  get "/recipes/new" do
    erb :new
  end

  ## end a new
  post '/recipes' do
    recipe = Recipe.create(params)

    redirect "/recipes/#{recipe.id}"
  end

  ## start an update
  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])

    erb :edit
  end

  ## end an update
  patch "/recipes/:id" do
    recipe = Recipe.find(params[:id])
    recipe.name = params[:name]
    recipe.ingredients = params[:ingredients]
    recipe.cook_time = params[:cook_time]
    recipe.save
    redirect "recipes/#{recipe.id}"
  end

  ## read and start delete option
  get "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  ## end a delete
  delete '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.delete

    redirect "/recipes"
  end

end
