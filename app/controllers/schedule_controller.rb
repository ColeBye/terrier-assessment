class ScheduleController < ApplicationController
  def index
    @work_orders = WorkOrder.all.sort_by { |w| w.date_time + (w.duration * 60) }
    @locations = Location.all
    @technicians = Technician.all
    if @work_orders.empty?
      @start_hour = 0
      @end_hour = 0
    else
      @start_hour = WorkOrder.order(date_time: :asc).pluck(:date_time).first.hour
      finish_times = []
      @work_orders.each do |order|
        finish_times.append(order.date_time + (order.duration * 60))
      end
      @end_hour = finish_times.max.hour + 1


      max_hour = finish_times.max.time
      @end_hour = if max_hour.min == 0 && max_hour.sec == 0 then max_hour.hour else max_hour.hour + 1 end
    end
  end

  def import
    work_order_form = params[:work_order_form]
    technician_form = params[:technician_form]
    location_form = params[:location_form]

    return redirect_to rake_schedule_index_path, notice: "Missing File/s" unless work_order_form && technician_form && location_form
    return redirect_to rake_schedule_index_path, notice: "CSV files only!" unless work_order_form.content_type == "text/csv" && technician_form.content_type == "text/csv" && location_form.content_type == "text/csv"

    CsvImportService.new.call(work_order_form, technician_form, location_form)

    redirect_to schedule_index_path
  end

  def rake
  end
end
