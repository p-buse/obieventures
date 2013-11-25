class AdventuresController < ApplicationController
  before_action :set_adventure, only: [:show, :edit, :update, :destroy]

  # GET /adventures
  # GET /adventures.json
  def index
    @adventures = Adventure.all
  end

  # GET /adventures/1
  # GET /adventures/1.json
  def show
  end

  # GET /adventures/new
  def new
    @adventure = Adventure.new
  end

  # GET /adventures/1/edit
  def edit
  end

  #Added by Adam. Stolen from http://archive.railsforum.com/viewtopic.php?id=46646.
  def like
    @adventure = Adventure.find(params[:id])
    #if statement eventually won't be needed
    if @adventure.likes == nil
      @adventure.likes = 0
    end
    #create an empty array labeled likes in the cookie if it doesn't exist
    #The following usage of ActiveSupport::JSON allows us to deal with arrays
    cookies.permanent[:likes] ||= ActiveSupport::JSON.encode([])
    likes = ActiveSupport::JSON.decode(cookies[:likes])
    #if the user has already liked the adventure, unlike it.
    if likes.include?(params[:id])
      likes.delete(params[:id])
      cookies[:likes] = ActiveSupport::JSON.encode(likes)
      @adventure.likes -= 1
      @adventure.save!
    #otherwise, like it and clear the marker from their cookie.
    else
      likes << params[:id]
      cookies[:likes] = ActiveSupport::JSON.encode(likes)
      @adventure.likes += 1
      @adventure.save!
    end
    #here there be majicks
    respond_to do |format|
      format.html {redirect_to :action=>:show}
      format.js
    end
  end

  # POST /adventures
  # POST /adventures.json
  def create
    @adventure = Adventure.new(adventure_params)

    respond_to do |format|
      if @adventure.save
        format.html { redirect_to @adventure, notice: 'Adventure was successfully created.' }
        format.json { render action: 'show', status: :created, location: @adventure }
      else
        format.html { render action: 'new' }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adventures/1
  # PATCH/PUT /adventures/1.json
  def update
    respond_to do |format|
      if @adventure.update(adventure_params)
        format.html { redirect_to @adventure, notice: 'Adventure was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @adventure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adventures/1
  # DELETE /adventures/1.json
  def destroy
    @adventure.destroy
    respond_to do |format|
      format.html { redirect_to adventures_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adventure
      @adventure = Adventure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adventure_params
      params.require(:adventure).permit(:summary, :details)
    end
end
