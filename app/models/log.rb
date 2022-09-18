class Log < ActiveRecord::Base
  validates :remote_ip, presence: true
  validates :request_method, presence: true
  validates :request_url, presence: true
  validates :response_status, presence: true
  validates :response_content_type, presence: true
end
