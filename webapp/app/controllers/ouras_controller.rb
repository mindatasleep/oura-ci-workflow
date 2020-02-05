class OurasController < ApplicationController
  before_action :set_oura, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]


  # GET /ouras
  # GET /ouras.json
  def index
    @ouras = Oura.all
  end

  # GET /ouras/1
  # GET /ouras/1.json
  def show
  end

  # GET /ouras/new
  def new
    @oura = current_user.ouras.build
  end

  # GET /ouras/1/edit
  def edit
  end

  # POST /ouras
  # POST /ouras.json
  def create
    @oura = current_user.ouras.build(oura_params)

    respond_to do |format|
      if @oura.save
        format.html { redirect_to @oura, notice: 'Oura was successfully created.' }
        format.json { render :show, status: :created, location: @oura }
      else
        format.html { render :new }
        format.json { render json: @oura.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ouras/1
  # PATCH/PUT /ouras/1.json
  def update
    respond_to do |format|
      if @oura.update(oura_params)
        format.html { redirect_to @oura, notice: 'Oura was successfully updated.' }
        format.json { render :show, status: :ok, location: @oura }
      else
        format.html { render :edit }
        format.json { render json: @oura.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ouras/1
  # DELETE /ouras/1.json
  def destroy
    @oura.destroy
    respond_to do |format|
      format.html { redirect_to ouras_url, notice: 'Oura was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oura
      @oura = Oura.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def oura_params
      params.require(:oura).permit(:user_id, :userinfo, :sleep, :activity, :readiness)
    end
end
