class PetsController < ApplicationController

  def owners
    @owners = Owner.all
    # sets a class method providing access to all the owners
  end

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
    # makes an array of all pet objects available in the @pets variable
    # renders the index page
  end

  get '/pets/new' do
    erb :'/pets/new'
    # render the new.erb page
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "/pets/#{ @pet.id }"
    # create pet
    # of owner name has no pets
    # set the pet's owner equal to a new owner object
    # save the pet
    # redirect to the pet's page based on it's unique id
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
    # finds the pet object based on the uri and saves it to the @pet instance variable
    # renders the /pets/show page
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
    # finds the pet object based on the uri and saves it to the @pet instance variable
    # renders the pets/edit page
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{ @pet.id }"
    # find pet by id and set equal to the instance variable @pet
    # update the db with the new parameters
    # if owner doesn't exist create a new one and update associate with pet
    # save @pet
    # redirect to that pet's unique page id
  end

end
