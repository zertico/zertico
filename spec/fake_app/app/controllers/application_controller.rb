class ApplicationController < Zertico::Controller
  include Rails.application.routes.url_helpers

  respond_to :html

  def render(attributes); end
end