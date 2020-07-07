class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]

  def index
    @polls = Poll.all
  end

  def show
  end

  private

  def set_poll
    @poll = Poll.includes(:options).find(params[:id])
    @is_voted = current_participant.voted_for? @poll
  end

  def correct_user
    if current_participant.nil?
      redirect_to root_path
    else
      redirect_to root_path unless current_participant.poll_id == @poll.id
    end
  end
end
