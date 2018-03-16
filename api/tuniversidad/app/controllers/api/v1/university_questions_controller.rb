# DEPRECATED
class Api::V1::UniversityQuestionsController < ApplicationController
  before_action :authenticate_with_token!, only: [:show,:index, :create,:destroy]
  respond_to :json

  def show
    u = UniversityQuestion.find_by(id:params[:id])
    u.answers = true
    render json: u, status:200
  end

  def index
    render json:UniversityQuestion.where(university_id: params[:university_id]), status:200
  end

  def create
    if params[:university_question] != {}
      pars = question_params
      q = UniversityQuestion.new do |q|
        q.user_id = current_user.id
        q.university_id = params[:university_id]
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
      q = UniversityAnswer.new do |q|
        q.user_id = current_user.id
        q.university_question_id = params[:id]
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
    if params[:university_question_id]
      u = UniversityQuestion.find_by(id:params[:university_question_id])
      ans = u.university_answers.find_by(id:params[:id])
      if ans.user_id == current_user.id
        ans.destroy
        head 204
      else
        head 401
      end
    else
      u = UniversityQuestion.find_by(id:params[:id]).destroy
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
    params.require(:university_question).permit(:university_id,:question,:details)
  end

  def answer_params
    params.require(:university_answer).permit(:university_question_id,:answer)
  end

end
