class UrlsController < ApplicationController

  def navigate
    slug = params[:slug]
    url = Url.active.find_by_slug(slug)
    if url
      url.num_clicks += 1
      url.save
      redirect_to url.long_url
    else
      head 404
    end
  end

  # GET /urls
  # GET /urls.json
  def index
    @url = Url.new
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)

    respond_to do |format|
      if @url.save
        format.html { redirect_to "/a/#{@url.admin_slug}", notice: 'Url was successfully created.' }
      else
        format.html { render :index }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:long_url, :active)
    end
end
