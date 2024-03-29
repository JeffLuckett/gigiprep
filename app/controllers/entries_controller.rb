class EntriesController < ApplicationController
  before_filter :init_session
  before_filter :get_entry, :only => [:show, :edit, :update, :destroy]

  respond_to :html, :json
  def index
    respond_to do |format|
      format.html
      format.json { render json: EntriesDatatable.new(view_context) }
    end
  end

  def show
  end

  def new
  end

  def create
    entry = Entry.create(params[:entry])
    redirect_to entry_path(entry)
  end

  def edit
  end

  def update
    @entry.update_attributes(params[:entry])
    respond_with @entry
  end

  def destroy
    @entry.destroy
    redirect_to request.referrer
  end

	def random
		@entry = Entry.get_random_n(1, session[:entry][:burned]).first
    session[:entry][:burned] << @entry.id
    @random = true
    return render :template=>'entries/show'
	end

  def reset
    session[:entry][:burned] = []
    return redirect_to request.referrer
  end

  private
  def init_session
    session[:entry] ||= {}
    session[:entry][:burned] ||= []
  end
  def get_entry
    @entry = Entry.find(params[:id]) if params[:id] rescue nil
    not_found unless @entry
  end
end
