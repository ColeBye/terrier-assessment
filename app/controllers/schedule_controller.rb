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
end
