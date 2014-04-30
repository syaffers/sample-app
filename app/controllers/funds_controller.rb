class FundsController < ApplicationController
  before_action :set_fund, only: [:edit,:update]

  # GET /funds/1/edit
  def edit
    @fund = Fund.first
  end

  # PATCH/PUT /funds/1
  # PATCH/PUT /funds/1.json
  def update
    if @fund.update(fund_params)
      redirect_to about_path, notice: 'Fund was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fund
      @fund = Fund.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fund_params
      params.require(:fund).permit(:needed, :collected)
    end
end
