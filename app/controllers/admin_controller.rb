class AdminController < ApplicationController
    before_action :set_url, only: [:show, :update]

  # GET /urls/1
  # GET /urls/1.json
  def show
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { render :show, notice: 'Url was successfully updated.' }
      else
        format.html { render :show }
      end
    end
  end
    
    private

    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find_by_admin_slug(params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:active)
    end
end
