class VisitsController < ApplicationController
  def index
    visits = Visit.all
    # FullCalendar の event 形式に変換 (終日イベント)
    render json: visits.map { |v|
      {
        id: v.id,
        title: v.visitor_name.presence || v.user&.email || "訪問",
        start: v.visit_on, allDay: true
      }
    }
  end

  def create
    visit = Visit.new(visit_params.merge(created_by: current_user))
    if visit.save
      render json: { ok: true, id: visit.id }
    else
      render json: { ok: false, errors: visit.errors.full_messages }, status: 422
    end
  end

  def destroy
    visit = Visit.find(params[:id])
    visit.destroy if visit.created_by == current_user # 作成者のみ削除できる等 任意の権限ルール
    head :no_content
  end

  private
  def visit_params
    params.require(:visit).permit(:visitor_name, :visit_on, :note, :user_id)
  end
end