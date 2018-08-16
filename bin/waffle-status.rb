#!/usr/bin/env ruby

require 'open3'

class String
  def color_code(code) "\x1b[#{code}m" end
  def colorize(code) "#{self.color_code(code)}#{self.sub(self.color_code(0), self.color_code(code))}#{self.color_code(0)}" end
  def bold; colorize(1) end
  def red; colorize(31) end
  def green; colorize(32) end
  def yellow; colorize(33) end
  def cyan; colorize(36) end
end

def ping_host(hostname)
  Open3.capture2("ping -t 1 #{hostname}")
end

def ping_hosts()
  ARGV.map do |hostname|
    Thread.new do
      output, status = ping_host(hostname)
      [hostname, status]
    end
  end.map(&:value).each do |arg|
    hostname, status = arg
    if status == 0
      puts "#{hostname} (online)"
    else
      puts "#{hostname} (offline)"
    end
  end

end

ping_hosts
