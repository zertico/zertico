class ApplicationController < Zertico::Controller
  include Rails.application.routes.url_helpers

  respond_to :html

  prepend_view_path 'spec/fake_app/app/views'
end