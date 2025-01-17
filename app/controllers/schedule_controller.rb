class ScheduleController < ApplicationController
  def index
    @work_orders = WorkOrder.all
    @locations = Location.all
    @technicians = Technician.all
  end
end
