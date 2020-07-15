class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = Note.all
  end

  def show

  end

  private
  def set_note
    @note = Note.find(params[:id])
  end

  def correct_user
    if current_participant.nil?
      redirect_to (root_path)
    else
      redirect_to root_path unless current_participant.note_id == @note.id
    end
  end
end
