class OwnersController < ApplicationController
  def pets
    @pets = Pet.all
    # makes an array of all the pet objects available as a method
  end

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
    # makes an array of all the owner objects
    # renders the list of owners
  end

  get '/owners/new' do
    erb :'/owners/new'
    # renders the new owner form
  end

  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save
    redirect "/owners/#{ @owner.id }"
    # create a new owner
    # if the owner has no pets create one
    # otherwise save the owner
    # redirect to owner show page
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
    # finds existing owner by id and sets instance variable @owner
    # renders edit owners page
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
    # finds existing owner id and sets instance variable @owner
    # renders owners show page
  end

  post '/owners/:id' do
     @owner = Owner.find(params[:id])
     @owner.update(params["owner"])
     if !params["pet"]["name"].empty?
       @owner.pets << Pet.create(name: params["pet"]["name"])
       @owner.save
     end
     redirect to "owners/#{@owner.id}"
     # finds an existing owner and sets instance variable @owner
     # updates @owner with form input owner params
     # if owner has no pets
     # create new pets with form input params and update owner's pets
     # save owner
     # redirect to the owner's unique id page
   end

end
