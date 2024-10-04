class Api::EbooksController < ApplicationController
  before_action :set_ebook, only: %i[ show update destroy preview ]

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

  def preview
    if @ebook.preview.attached?
      @ebook.increment!(:total_previews, 1) # Increment the 'views' field by 1
      return render json: { url: rails_blob_path(@ebook.preview, only_path: true), total_previews: @ebook.total_previews }, status: :ok
    end
    render json: {}, status: :record_not_found
  end

  # PATCH/PUT /ebooks/1
  def update
    @ebook.update!(ebook_update_params)
    if params[:ebook][:preview].present?
      @ebook.attach_file!(params[:ebook][:preview], :preview, attach_file_key)
    end
    if params[:ebook][:full_ebook].present?
      @ebook.attach_file!(params[:ebook][:full_ebook], :full_ebook, attach_file_key)
    end
    render json: @ebook, status: :ok
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

    def attach_file_key
      "#{Rails.env}/ebooks/#{@ebook[:id]}/"
    end
end
