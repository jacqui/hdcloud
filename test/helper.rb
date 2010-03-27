require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'fakeweb'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'hdcloud'

class Test::Unit::TestCase
  FakeWeb.allow_net_connect = false
  def create_job_success
    <<-END
[{"job": 
   {"source_filename": "beer-drinking-pig.mpg",
    "encoding_profile_id": nil,
    "current_step": "waiting_for_file",
    "resolution": nil,
    "status_url": "http://example.com/api/v1/jobs/1.json",
    "id": 1,
    "bitrate": nil,
    "current_status": "waiting for file",
    "current_progress": nil,
    "remote_id": "my-own-remote-id"}}]
END
  end

  def job_status_success
    <<-END
{"job": 
  {"source_filename": "beer-drinking-pig.mpg",
   "encoding_profile_id": nil,
   "current_step": "encoding",
   "resolution": nil,
   "status_url": "http://example.com/api/v1/jobs/1.json",
   "id": 1,
   "bitrate": nil,
   "current_status": "Encoding: Pass 1",
   "current_progress": 42,
   "remote_id": "my-own-remote-id"}}
END
  end

  def jobs_success
    <<-END
[{"job": 
   {"source_filename": "beer-drinking-pig.mpg",
    "encoding_profile_id": nil,
    "current_step": "encoding",
    "resolution": nil,
    "status_url": "http://example.com/api/v1/jobs/1.json",
    "id": 1,
    "bitrate": nil,
    "current_status": "Encoding: Pass 1",
    "current_progress": 42,
    "remote_id": "my-own-remote-id"}}]
END
  end
  def current_jobs_success
    <<-END
[{"job": 
   {"source_filename": "beer-drinking-pig.mpg",
    "encoding_profile_id": nil,
    "current_step": "encoding",
    "resolution": nil,
    "status_url": "http://example.com/api/v1/jobs/1.json",
    "id": 1,
    "bitrate": nil,
    "current_status": "Encoding: Pass 1",
    "current_progress": 42,
    "remote_id": "my-own-remote-id"}}]
END
  end
  def completed_jobs_success
    <<-END
[{"job": 
   {"source_filename": "beer-drinking-pig.mpg",
    "encoding_profile_id": nil,
    "current_step": nil,
    "resolution": nil,
    "status_url": "http://example.com/api/v1/jobs/1.json",
    "id": 1,
    "complete?": true,
    "encoded_filename": "beer-drinking-pig_1_800_1920x1080.mp4",
    "bitrate": nil,
    "current_status": "completed",
    "current_progress": nil,
    "remote_id": "my-own-remote-id"}}]
END
  end
  def failed_jobs_success
    <<-END
[{"job": 
   {"source_filename": "beer-drinking-pig.mpg",
    "encoding_profile_id": nil,
    "current_step": "failed",
    "resolution": nil,
    "status_url": "http://example.com/api/v1/jobs/1.json",
    "failed?": true,
    "id": 1,
    "bitrate": nil,
    "current_status": "failed",
    "failure_code": 500,
    "failure_message": 
     "An unexpected application error occurred. Please contact support.",
    "current_progress": nil,
    "remote_id": "my-own-remote-id"}}]
END
  end
  def stores_success
    <<-END
{"stores": 
  [{"name": "Example Store",
    "cdn": "S3",
    "username": "123abc",
    "auth_token": nil,
    "description": "Example Store",
    "deleted": false,
    "host": nil,
    "ref": "example-bucket",
    "user_id": 1,
    "authorized": false,
    "password": "cba321"}]}
END
  end
end
