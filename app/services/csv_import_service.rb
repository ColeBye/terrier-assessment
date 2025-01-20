class CsvImportService
  require "csv"

  def call(work_order_form, technician_form, location_form)
    # Open and parse work order CSV
    work_order_file = File.open(work_order_form.path)
    csv = CSV.parse(work_order_file, headers: true, col_sep: ",")

    # Create objects to add to database
    csv.each do |row|
      work_order_hash = {}
      work_order_hash[:order_id] = row[0]
      work_order_hash[:technician] = row["technician_id"]
      work_order_hash[:location] = row["location_id"]
      work_order_hash[:duration] = row["duration"]
      work_order_hash[:price] = row["price"]
      work_order_hash[:date_time] = row["time"]
      WorkOrder.create(work_order_hash)
    end

    # Open and parse technician CSV
    technician_file = File.open(technician_form.path)
    csv = CSV.parse(technician_file, headers: true, col_sep: ",")

    # Create objects to add to database
    csv.each do |row|
      technician_hash = {}
      technician_hash[:technician_id] = row[0]
      technician_hash[:name] = row["name"]
      Technician.create(technician_hash)
    end

    # Open and parse location CSV
    location_file = File.open(location_form.path)
    csv = CSV.parse(location_file, headers: true, col_sep: ",")

    # Create objects to add to database
    csv.each do |row|
      location_hash = {}
      location_hash[:location_id] = row[0]
      location_hash[:name] = row["name"]
      location_hash[:city] = row["city"]
      Location.create(location_hash)
    end
  end
end
