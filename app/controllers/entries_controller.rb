class EntriesController < ApplicationController
  before_filter :init_session
	def random
		@entry = Entry.get_random_n(1, session[:entry][:burned]).first
    session[:entry][:burned] << @entry.id
	end

  private
  def init_session
    session[:entry] ||= {}
    session[:entry][:burned] ||= []
  end
end
