class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]
  respond_to :html, :json

  # GET /people or /people.json
  def index
    @people = Person.all
  end

  # GET /people/1 or /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params)
    flash[:notice] = 'Pessoa salva com sucesso!' if @person.save
    respond_with @person
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    flash[:notice] = 'Pessoa atualizada com sucesso!' if @person.update(person_params)
    respond_with @person
  end

  # GET /people/admins
  def admins
    @admins = Person.admins
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    flash[:notice] = 'Pessoa deletada com sucesso!' if @person.destroy
    respond_with @person
    @person.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:name, :email, :password, :born_at, :admin,:password_confirmation)
    end
end
