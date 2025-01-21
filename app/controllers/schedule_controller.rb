class ScheduleController < ApplicationController
  def index
    # Setup collections from database
    @work_orders = WorkOrder.all.sort_by { |work_order| work_order.date_time + (work_order.duration * 60) }
    @locations = Location.all
    @technicians = Technician.all

    # Setup instance variables for beginning and end of day.
    if @work_orders.empty?
      @start_hour = 0
      @end_hour = 0
    else
      @start_hour = WorkOrder.order(date_time: :asc).pluck(:date_time).first.hour
      finish_times = []
      @work_orders.each do |work_order|
        finish_times.append(work_order.date_time + (work_order.duration * 60))
      end
      max_hour = finish_times.max.time
      @end_hour = if max_hour.min == 0 && max_hour.sec == 0 then max_hour.hour else max_hour.hour + 1 end
    end
  end

  def import
    # Gets file object
    work_order_form = params[:work_order_form]
    technician_form = params[:technician_form]
    location_form = params[:location_form]

    # Check if all files are input and all files are csv
    return redirect_to rake_schedule_index_path, notice: "Missing File/s" unless work_order_form && technician_form && location_form
    return redirect_to rake_schedule_index_path, notice: "CSV files only!" unless (work_order_form.content_type == "text/csv" || work_order_form.content_type == "application/vnd.ms-excel") && (technician_form.content_type == "text/csv" || technician_form.content_type == "application/vnd.ms-excel") && (location_form.content_type == "text/csv" || location_form.content_type == "application/vnd.ms-excel")

    # Adds info from files to the database
    # my_var = File.open(work_order_form)
    # or .path
    CsvImportService.new.call(work_order_form.path, technician_form.tempfile, location_form.tempfile)

    redirect_to schedule_index_path
  end
end
