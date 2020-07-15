class VotesController < ApplicationController
  def create
    if current_participant && params[:poll] && params[:poll][:id] && params[:vote_option] && params[:vote_option][:id]
      @poll = Poll.find_by_id(params[:poll][:id])
      @option = @poll.options.find_by_id(params[:vote_option][:id])
      if @option && @poll && !current_participant.voted_for?(@poll)
        current_participant.votes.create({option_id: @option.id})
        @is_voted = current_participant.voted_for? @poll
      else
        render js: 'alert(\'Your vote cannot be saved. Have you already voted?\');'
      end
    else
      render js: 'alert(\'Your vote cannot be saved.\');'
    end
  end
end