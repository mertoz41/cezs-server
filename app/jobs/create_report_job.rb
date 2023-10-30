class CreateReportJob < ApplicationJob
    queue_as :default
  
    def perform(params)
      ReportCreator.new(params).create!
    end
  end
  