class NotesController < ApplicationController
  def show
    @note = Note.friendly.find(params[:id])
  end
end
