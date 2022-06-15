class PeopleController < AdminController
  before_action :set_person, only: %i[ show edit update destroy changed]
  respond_to :html, :json

  # GET /people or /people.json
  def index
    @people = Person.all
  end

  # GET /people/1 or /people/1.json
  def show
    @person = PersonPresenter.new(@person)
    respond_with @person
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
    @person.admin = params[:admin] if session[:admin]
    flash[:notice] = 'Pessoa salva com sucesso!' if @person.save
    respond_with @person
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    @person.admin = params[:admin] if session[:admin]
    flash[:notice] = 'Pessoa atualizada com sucesso!' if @person.update(person_params)
    respond_with @person
  end

  # GET /people/admins
  def admins
    @admins = Person.admins
  end

  # GET /people/1/changed
  def changed
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
      params.require(:person).permit(:name, :email, :password, :born_at, :password_confirmation)
    end
end
