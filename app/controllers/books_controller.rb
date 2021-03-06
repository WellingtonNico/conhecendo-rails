class BooksController < LoggedController
  layout = 'pub'
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :load_categories, only: %i[ new update edit create ]
  before_action :load_people, only: %i[ new update edit create ]
  respond_to :html, :json

  # GET /books or /books.json
  def index
    @books = Book.page(params[:page]).per(1)
  end

  # GET /books/1 or /books/1.json
  def show
    @book = BookPresenter.new(@book)
    respond_with @book
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: 'Livro criado com sucesso' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Livro atualizado com sucesso" }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Livro deletado com sucesso" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :published_at, :text, :value, :person_id, :image_title, :data_stream, :stock, category_ids:[])
    end

    def load_categories
      @categories = Category.all
    end

    def load_people
      @people = Person.all
    end
end
