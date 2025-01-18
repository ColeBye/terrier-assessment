class ScheduleController < ApplicationController
  def index
    @work_orders = WorkOrder.all
    @locations = Location.all
    @technicians = Technician.all
    if @work_orders.empty?
      @start_hour = 0
      @end_hour = 0
    else
      # @start_hour = WorkOrder.order(date_time: :asc).pluck(:date_time).first.hour
      @start_hour = 0
      # finish_times = []
      # @work_orders.each do |order|
      #   finish_times.append(order.date_time + order.duration)
      # end
      # @end_hour = finish_times.max.hour + 1
      @end_hour = 0
    end
  end

  def import
    work_order_form = params[:work_order_form]
    technician_form = params[:technician_form]
    location_form = params[:location_form]
    # params.except(:work_order_file, :technician_form, :location_form)


    return redirect_to schedule_index_path, notice: "Missing File/s" unless work_order_form && technician_form && location_form
    return redirect_to schedule_index_path, notice: "CSV files only!" unless work_order_form.content_type == "text/csv" && technician_form.content_type == "text/csv" && location_form.content_type == "text/csv"

    CsvImportService.new.call(work_order_form, technician_form, location_form)

    redirect_to schedule_index_path, notice: "CSV Imported"
  end
end
