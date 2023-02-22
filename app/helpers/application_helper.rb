# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def seconds_to_str(seconds)
    return nil if seconds.nil?

    ["#{seconds / 3600}h", "#{seconds / 60 % 60}m", "#{seconds % 60}s"]
      .select { |str| str =~ /[1-9]/ }.join(" ")
  end
end
