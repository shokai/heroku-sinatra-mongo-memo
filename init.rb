require 'yaml'
require 'mongoid'

## Model
class Memo
  include Mongoid::Document
  field :created_at, :type => Time, :default => lambda{ Time.now }
  field :body, :type => String, :default => ""

  def self.find_by_id(id)
    self.where(:id => id).first
  end

  def self.latests(num=10)
    self.all.desc(:created_at).limit(num)
  end
end

## Connect MongoDB
Mongoid.logger.level =
  case ENV['RACK_ENV']
  when 'production'
    Logger::WARN
  else
    Logger::DEBUG
  end

Mongoid.configure do |conf|
  h = {'uri' => ENV['MONGOLAB_URI'] || ENV['MONGOHQ_URL']}
  unless h['uri']
    yaml = YAML.load(open(File.expand_path 'mongoid.yml', File.dirname(__FILE__)).read)
    h = yaml[ ENV['RACK_ENV'] || 'development' ]
  end
  conf.from_hash h
end
