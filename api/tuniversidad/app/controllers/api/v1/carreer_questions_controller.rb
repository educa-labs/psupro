
# DEPRECATED
class Api::V1::CarreerQuestionsController < ApplicationController
  before_action :authenticate_with_token!, only: [:show,:index, :create,:destroy]
  respond_to :json

  def show
    u = CarreerQuestion.find_by(id:params[:id])
    u.answers = true
    render json: u, status:200
  end

  def index
    render json:CarreerQuestion.where(carreer_id: params[:carreer_id]), status:200
  end

  def create
    if params[:carreer_question] != {}
      pars = question_params
      q = CarreerQuestion.new do |q|
        q.user_id = current_user.id
        q.carreer_id = params[:carreer_id]
        q.question = pars[:question]
        q.details = pars[:details]
      end
      if q.save
        render json:q ,status:200
      else
        render json:{errors: q.errors}, status: 422
      end
    else
      pars = answer_params
      q = CarreerAnswer.new do |q|
        q.user_id = current_user.id
        q.carreer_question_id = params[:id]
        q.answer = pars[:answer]
      end
      if q.save
        render json:q ,status:200
      else
        render json:{errors: q.errors}, status: 422
      end
    end
  end

  def destroy
    if params[:carreer_question_id]
      u = CarreerQuestion.find_by(id:params[:carreer_question_id])
      ans = u.carreer_answers.find_by(id:params[:id])
      if ans.user_id == current_user.id
        ans.destroy
        head 204
      else
        head 401
      end
    else
      u = CarreerQuestion.find_by(id:params[:id]).destroy
      if u.user_id == current_user.id
        u.destroy
        head 204
      else
        head 401
      end
    end
  end

  private

  def question_params
    params.require(:carreer_question).permit(:carreer_id,:question,:details)
  end

  def answer_params
    params.require(:carreer_answer).permit(:carreer_question_id,:answer)
  end
  
end
