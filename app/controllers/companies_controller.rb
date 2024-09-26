class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show update destroy ]

  # GET /companies
  def index
    render json: Company.all, status: :ok
  end

  # GET /companies/1
  def show
    render json: @company, status: :ok
  end

  # POST /companies
  def create
    @company = Company.create!(company_params)
    render json: @company, status: :created
  end

  # PATCH/PUT /companies/1
  def update
    @company.update!(company_params)
    render json: @company, status: :ok
  end

  # DELETE /companies/1
  def destroy
    @company.destroy!
    render json: {},  status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :user_id)
    end
end
