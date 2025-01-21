namespace :csv_input do
  desc "Import data from csv into database"
  task :import_csv, [ :work_order_file, :technician_file, :location_file ] => [ :environment ] do |t, args|
    work_order_path = Rails.root.join("tmp/", args[:work_order_file])
    technician_path = Rails.root.join("tmp/", args[:technician_file])
    location_path = Rails.root.join("tmp/", args[:location_file])

    # Check valid usage
    unless File.exist?(work_order_path) && File.exist?(technician_path) && File.exist?(location_path)
      puts "Missing File arg/s"
    end
    # Call service
    CsvImportService.new.call(work_order_path, technician_path, location_path)
    puts "Import Complete!"
  end
end

# Usage: rake "csv_input:import_csv[work_orders.csv, technicians.csv, locations.csv]"
# #{Rails.root}/mp/filename.csv
