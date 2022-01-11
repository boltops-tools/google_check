require "google/cloud/storage"

class Check
  def initialize
    # So google sdk newer versions use GOOGLE_CLOUD_PROJECT instead of GOOGLE_PROJECT
    # Found out between google-cloud-storage-1.35.0 and google-cloud-storage-1.28.0
    # Though it seems like an library underneath that with the change.
    # Keeping backwards compatibility to not create breakage users who already have GOOGLE_PROJECT
    # But then setting GOOGLE_CLOUD_PROJECT so it works with the SDK.
    # For users, who set GOOGLE_CLOUD_PROJECT that will work also.
    ENV['GOOGLE_CLOUD_PROJECT'] ||= ENV['GOOGLE_PROJECT']
  end

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
    @storage ||= Google::Cloud::Storage.new
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
