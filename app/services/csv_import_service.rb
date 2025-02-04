class CsvImportService
  require "csv"

  def call(work_order_form, technician_form, location_form)
    # Open and parse work order CSV
    work_order_file = File.read(work_order_form)
    csv = CSV.parse(work_order_file, headers: true, col_sep: ",")

    # Create objects to add to database
    csv.each do |row|
      unless WorkOrder.where(order_id: row[0]).exists?
        work_order_hash = {}
        work_order_hash[:order_id] = row[0]
        work_order_hash[:technician] = row["technician_id"]
        work_order_hash[:location] = row["location_id"]
        work_order_hash[:duration] = row["duration"]
        work_order_hash[:price] = row["price"]
        work_order_hash[:date_time] = row["time"]
        WorkOrder.create(work_order_hash)
      end
    end

    # Open and parse technician CSV
    technician_file = File.read(technician_form)
    csv = CSV.parse(technician_file, headers: true, col_sep: ",")

    # Create objects to add to database
    csv.each do |row|
      unless Technician.where(technician_id: row[0]).exists?
        technician_hash = {}
        technician_hash[:technician_id] = row[0]
        technician_hash[:name] = row["name"]
        Technician.create(technician_hash)
      end
    end

    # Open and parse location CSV
    location_file = File.read(location_form)
    csv = CSV.parse(location_file, headers: true, col_sep: ",")

    # Create objects to add to database
    csv.each do |row|
      unless Location.where(location_id: row[0]).exists?
        location_hash = {}
        location_hash[:location_id] = row[0]
        location_hash[:name] = row["name"]
        location_hash[:city] = row["city"]
        Location.create(location_hash)
      end
    end
  end
end
