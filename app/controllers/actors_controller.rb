class ActorsController < ApplicationController
  before_action :set_actor, only: %i[ show edit update destroy ]

  def index
    @actors = Actor.all
  end

  def show; end

  def new
    @actor = Actor.new
  end

  def edit; end

  def create
    @actor = Actor.new(actor_params)

    respond_to do |format|
      if @actor.save
        format.html { redirect_to @actor, notice: "actor was successfully created." }
        format.json { render :show, status: :created, location: @actor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @actor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @actor.update(actor_params)
        format.html { redirect_to @actor, notice: "actor was successfully updated." }
        format.json { render :show, status: :ok, location: @actor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @actor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @actor.destroy!

    respond_to do |format|
      format.html { redirect_to actors_path, status: :see_other, notice: "actor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_actor
    @actor = Actor.find(params[:id])
  end

  def actor_params
    params.require(:actor).permit(:name)
  end
end
