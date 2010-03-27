require File.dirname(__FILE__) + '/../helper'

class BaseTest < Test::Unit::TestCase
  context "base" do
    setup do
      HDCloud::Base.any_instance.stubs(:hd_cloud_stores).returns({:source_id => 3, :destination_id => 4})
    end

    should "accept source_id and destination_id as parameters" do
      hd = HDCloud::Base.new('foo', 'bar', 1, 2)
      assert_equal 1, hd.source_id
      assert_equal 2, hd.destination_id
    end

    should "use the constant otherwise" do
      hd = HDCloud::Base.new('foo', 'bar')
      assert_equal 3, hd.source_id
      assert_equal 4, hd.destination_id
    end

    should "login with key and pass" do
      HDCloud::Base.expects(:basic_auth).with('foo', 'bar')
      HDCloud::Base.new('foo', 'bar')
    end

    context "once initialized" do
      setup do
        @hd = HDCloud::Base.new('foo', 'bar', 1, 2)
      end

      context "#create_job" do
        setup do
          FakeWeb.register_uri(:post, %r|http://foo:bar@hdcloud.com/api/v1/jobs|, :body => create_job_success, :content_type => 'application/json')
        end
        should "post to HDCloud" do
          assert_equal 'waiting_for_file', @hd.create_job('foo.mp4').first["job"]["current_step"]
        end
      end

      context "#job_status" do
        setup do
          FakeWeb.register_uri(:get, %r|http://foo:bar@hdcloud.com/api/v1/jobs/1|, :body => job_status_success, :content_type => 'application/json')
        end

        should "submit a get request to the job's status url" do
          @hd.job_status('http://hdcloud.com/api/v1/jobs/1')
        end
      end

      context "#jobs" do
        setup do
          FakeWeb.register_uri(:get, %r|http://foo:bar@hdcloud.com/api/v1/jobs|, :body => jobs_success, :content_type => "application/json")
        end

        should "submit a get request to jobs" do
          assert_equal 1, @hd.jobs.first["job"]["id"]
        end
      end

      context "#current_jobs" do
        setup do
          FakeWeb.register_uri(:get, %r|http://foo:bar@hdcloud.com/api/v1/jobs/current|, :body => current_jobs_success, :content_type => 'application/json')
        end

        should "submit a get request to jobs/current" do
          assert_equal 1, @hd.current_jobs.first["job"]["id"]
          assert_equal 'encoding', @hd.current_jobs.first["job"]["current_step"]
        end
      end
      context "#completed_jobs" do
        setup do
          FakeWeb.register_uri(:get, %r|http://foo:bar@hdcloud.com/api/v1/jobs/complete|, :body => completed_jobs_success, :content_type => 'application/json')
        end

        should "submit a get request to jobs/completed" do
          assert_equal 1, @hd.completed_jobs.first["job"]["id"]
        end
      end
      context "#failed_jobs" do
        setup do
          FakeWeb.register_uri(:get, %r|http://foo:bar@hdcloud.com/api/v1/jobs/failed|, :body => failed_jobs_success, :content_type => 'application/json')
        end

        should "submit a get request to jobs/failed" do
          assert_equal 1, @hd.failed_jobs.first["job"]["id"]
          assert_equal 'failed', @hd.failed_jobs.first["job"]["current_status"]
        end
      end
    end
  end
end
