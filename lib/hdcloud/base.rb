module HDCloud
  class Base
    attr_accessor :source_id, :destination_id

    include HTTParty
    base_uri 'hdcloud.com/api/v1'
    format :json

    def hd_cloud_stores
      HD_CLOUD_STORES || {}
    end

    def initialize(key, pass, source_id = nil, destination_id = nil)
      @source_id = source_id || hd_cloud_stores[:source_id]
      @destination_id = destination_id || hd_cloud_stores[:destination_id]
      self.class.default_params 'job[source_id]' => source_id, 'job[destination_id]' => destination_id
      self.class.basic_auth key, pass
    end

    def create_job(file_name, encoding_profile_ids = [])
      response = self.class.post('/jobs.json', :query => { 'files[]' => file_name, 'encoding_profile_ids[]' => encoding_profile_ids })
      raise_errors(response)
      response
    end

    def job_status(status_url)
      status_url = status_url + '.json' unless status_url.match(/json$/)
      response = self.class.get(status_url)
      raise_errors(response)
      response
    end

    def jobs
      response = self.class.get('/jobs.json')
      raise_errors(response)
      response
    end

    def failed_jobs
      response = self.class.get('/jobs/failed.json')
      raise_errors(response)
      response
    end

    def current_jobs
      response = self.class.get('/jobs/current.json')
      raise_errors(response)
      response
    end

    def completed_jobs
      response = self.class.get('/jobs/completed.json')
      raise_errors(response)
      response
    end

    def raise_errors(response)
      case response.code.to_i
        when 400
          data = parse(response)
          raise RateLimitExceeded.new(data), "(#{response.code}): #{response.message} - #{data['error'] if data}"
        when 401
          data = parse(response)
          raise Unauthorized.new(data), "(#{response.code}): #{response.message} - #{data['error'] if data}"
        when 403
          data = parse(response)
          raise General.new(data), "(#{response.code}): #{response.message} - #{data['error'] if data}"
        when 404
          raise NotFound, "(#{response.code}): #{response.message}"
        when 500
          raise InformHDCloud, "HDCloud had an internal error. Please let them know in the group. (#{response.code}): #{response.message}"
        when 502..503
          raise Unavailable, "(#{response.code}): #{response.message}"
      end
    end
  end
end
