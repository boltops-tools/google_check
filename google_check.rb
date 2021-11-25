require "google/cloud/storage"

class Check
  def call
    # Make an authenticated API request
    puts "Listing gcs buckets as a test"
    if storage.buckets.empty?
      puts "There are no GCS buckets in this project. But the Googgle SDK API successful."
    else
      storage.buckets.each do |bucket|
        puts bucket.name
      end
    end
    puts "Successfully connected to Google API with your GOOGLE_APPLICATION_CREDENTIALS"
  end

  def storage
    @storage ||= Google::Cloud::Storage.new(project: project)
  end

  def project
    creds['project_id']
  end

  def creds
    return @creds if @creds
    creds_path = ENV['GOOGLE_APPLICATION_CREDENTIALS']
    unless File.exist?(creds_path)
      puts "ERROR: #{creds_path} does not exist. Double check GOOGLE_APPLICATION_CREDENTIALS"
      exit 1
    end
    @creds = JSON.load(IO.read(creds_path))
  end
end

if __FILE__ == $0
  Check.new.call
end
