class ScheduleController < ApplicationController

  def index
    @work_orders = WorkOrder.all
    @locations = Location.all
    @technicians = Technician.all
    if @work_orders.empty?
      @start_hour = 0
      @end_hour = 0
    else
      @start_hour = WorkOrder.order(date_time: :asc).pluck(:date_time).first.hour
      finish_times = []
      @work_orders.each do |order|
        finish_times.append(order.date_time + order.duration)
      end
      @end_hour = finish_times.max.hour + 1
    end
  end

  def import
    puts("test")
    work_order_file = params[:work_order_file]
    technician_file = params[:technician_file]
    location_file = params[:location_file]

    return redirect_to schedule_index_path, alert: "Missing File/s" unless work_order_file && technician_file && location_file
    return redirect_to schedule_index_path, notice: "CSV files only" unless work_order_file.content_type == "text/csv" && technician_file.content_type == "text/csv" && location_file.content_type == "text/csv"

    work_order_file = File.open(work_order_file.to_s)
    csv = CSV.parse(work_order_file, headers: true, col_sep: ";")
    csv.each do |row|
      work_order_hash = {}
      work_order_hash[:id] = row["id"]
      work_order_hash[:technician] = row["technician_id"]
      work_order_hash[:location] = row["location_id"]
      work_order_hash[:date_time] = row["time"]
      work_order_hash[:duration] = row["duration"]
      work_order_hash[:price] = row["price"]
      WorkOrder.create(work_order_hash)
    end
    technician_file = File.open(technician_file.to_s)
    csv = CSV.parse(technician_file, headers: true, col_sep: ";")
    csv.each do |row|
      technician_hash = {}
      technician_hash[:id] = row["id"]
      technician_hash[:name] = row["name"]
      Technician.create(technician_hash)
    end
    location_file = File.open(location_file.to_s)
    csv = CSV.parse(location_file, headers: true, col_sep: ";")
    csv.each do |row|
      location_hash = {}
      location_hash[:id] = row["id"]
      location_hash[:name] = row["name"]
      location_hash[:city] = row["city"]
      Location.create(location_hash)
    end


    redirect_to schedule_index_path, notice: "CSV Imported"
  end
end
