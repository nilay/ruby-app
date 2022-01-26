class ServerLogParser
  attr_reader :message

  def initialize(log_file)
    @log_file = log_file
    @success = true
    @message = nil
  end

  def parse
    make_fail("ERROR: '#{@log_file}' do not exists") || return unless File.file?(@log_file)

    log_data = File.read(@log_file)

    # convert server log file's each line into double dimension array
    array_data = log_data.split.each_slice(2).to_a
    hash_data = array_data.group_by(&:first)

    # put total count and unique count as array of hashes
    result = []
    hash_data.each do |key, value|
      result << {uri: key, count: value.count, unique_count: value.uniq.count}
    end

    # sort by count in descending order before return
    (result.sort_by { |hsh| hsh[:count] }).reverse
  end

  def make_fail(message)
    @message = message
    @success = false
  end

  def success?
    @success
  end
end