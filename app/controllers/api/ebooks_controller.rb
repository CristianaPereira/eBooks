class Api::EbooksController < ApplicationController
  before_action :set_ebook, only: %i[ show update destroy ]

  # GET /ebooks
  def index
    render json: Ebook.filter(filter_params), status: :ok
  end

  # GET /ebooks/1
  def show
    render json: @ebook, status: :ok
  end

  # POST /ebooks
  def create
    @ebook = Ebook.create!(ebook_create_params)
    render json: @ebook, status: :created
  end

  # PATCH/PUT /ebooks/1
  def update
    @ebook.update!(ebook_update_params)
    set_preview
    render json: @ebook, status: :ok
  end

  def set_preview
    return unless params[:ebook][:preview].present?
    file = params[:ebook][:preview]
    @ebook.attach_file!(file, :preview, preview_file_key)
  end


  def buy
    @order  = Orders::Create.call(@current_user.id, params[:id])
    render json: @order, status: :created
  end

  # DELETE /ebooks/1
  def destroy
    @ebook.destroy!
    render json: {},  status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ebook
      @ebook = Ebook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ebook_update_params
      params.require(:ebook).permit(:title, :status, :price)
    end

    def ebook_create_params
      params.require(:ebook).permit(:title, :status, :company_id, :price)
    end

    def filter_params
      params.permit(:name, :owner_id)
    end

    def preview_file_key
      "#{Rails.env}/ebooks/#{@ebook[:id]}/"
    end
end
