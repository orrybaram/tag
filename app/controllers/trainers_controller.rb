
class TrainersController < ApplicationController
  # GET /trainers
  # GET /trainers.json
  def index
    @trainers = Trainer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @trainers }
    end
  end

  # GET /trainers/1
  # GET /trainers/1.json
  def show
    @trainer = Trainer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @trainer }
    end
  end

  # GET /trainers/new
  # GET /trainers/new.json
  def new
    @trainer = Trainer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @trainer }
    end
  end

  # GET /trainers/1/edit
  def edit
    @trainer = Trainer.find(params[:id])
  end

  # POST /trainers
  # POST /trainers.json
  def create
    @trainer = Trainer.new(params[:trainer])

    respond_to do |format|
      if @trainer.save
        format.html { redirect_to @trainer, :notice => 'Trainer was successfully created.' }
        format.json { render :json => @trainer, :status => :created, :location => @trainer }
      else
        format.html { render :action => "new" }
        format.json { render :json => @trainer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trainers/1
  # PUT /trainers/1.json
  def update
    @trainer = Trainer.find(params[:id])

    respond_to do |format|
      if @trainer.update_attributes(params[:trainer])
        format.html { redirect_to @trainer, :notice => 'Trainer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @trainer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trainers/1
  # DELETE /trainers/1.json
  def destroy
    @trainer = Trainer.find(params[:id])
    @trainer.destroy

    respond_to do |format|
      format.html { redirect_to trainers_url }
      format.json { head :no_content }
    end
  end
end
