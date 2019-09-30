class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner_id])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(params["owner"])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end
  
  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end
    
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name], owner_id: params[:owner_id])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(params["owner"])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end
end