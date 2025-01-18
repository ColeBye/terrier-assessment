class ScheduleController < ApplicationController
  require "csv"
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
    # redirect_to schedule_index_path, notice: "TEST" unless @work_orders.count > 0
    logger.info("PARAMSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS: #{params[:work_order_file]}")
    work_order_form = params[:work_order_form]
    technician_file = params[:technician_file]
    location_file = params[:location_file]
    logger.info("EEEEEE")
    logger.info(params[:work_order_form])
    params.except(:work_order_file, :location_file, :technician_file)

    # return redirect_to schedule_index_path, notice: "Missing File/s" unless work_order_file # && technician_file && location_file
    return redirect_to schedule_index_path, notice: "CSV files only" unless work_order_form.content_type == "text/csv" # && technician_file.content_type == "text/csv" && location_file.content_type == "text/csv"

    work_order_file = File.open(work_order_form.path)
    logger.info("WorkOrder: #{work_order_file}")
    csv = CSV.parse(work_order_file, headers: true, col_sep: ",")
    csv.each do |row|
      logger.info("ROW #{row[0]} #{row[1]} #{row[2]}")
      work_order_hash = {}
      work_order_hash[:order_id] = row[0]
      work_order_hash[:technician] = row[1]
      work_order_hash[:location] = row[2]
      work_order_hash[:duration] = row[3]
      work_order_hash[:price] = row[4]
      work_order_hash[:date_time] = row[5]

      logger.info("HASH #{work_order_hash}")
      WorkOrder.create(work_order_hash)
    end
    # technician_file = File.open(technician_file.to_s)
    # csv = CSV.parse(technician_file, headers: true, col_sep: ";")
    # csv.each do |row|
    #   technician_hash = {}
    #   technician_hash[:id] = row["id"]
    #   technician_hash[:name] = row["name"]
    #   Technician.create(technician_hash)
    # end
    # location_file = File.open(location_file.to_s)
    # csv = CSV.parse(location_file, headers: true, col_sep: ";")
    # csv.each do |row|
    #   location_hash = {}
    #   location_hash[:id] = row["id"]
    #   location_hash[:name] = row["name"]
    #   location_hash[:city] = row["city"]
    #   Location.create(location_hash)
    # end


    redirect_to schedule_index_path, notice: "CSV Imported"
  end
end
