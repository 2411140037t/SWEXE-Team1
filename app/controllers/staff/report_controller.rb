class Staff::ReportController < Staff::BaseController
  include TagSelectable

  before_action :set_report, only: %i[show update]

  def index
    # TODO: 職員用の報告一覧ページ
  end

  def show
  end

  def update
    @report.select_tags(selected_tag_ids, source: "staff") if tag_choices_submitted?
    # TODO: 承認・却下（status / reject_reason）の更新もここに追加する

    if @report.save
      redirect_to staff_report_path(@report), notice: "更新しました"
    else
      render :show, status: :unprocessable_content
    end
  end

  private

  def set_report
    @report = Report.includes(report_tags: :tag).find(params[:id])
  end
end