module Zertico
  module Responder
    def initialize(controller, resources, options={})
      super
      @force_redirect = options.delete(:force_redirect)
    end

    protected

    def default_render
      if request.headers['X-PJAX']
        render :layout => false
      else
        super
      end
    end

    def navigation_behavior(error)
      if get?
        raise error
      elsif has_errors? && default_action
        if @force_redirect
          controller.flash.keep
          redirect_to navigation_location
        else
          controller.flash.clear
          render :action => default_action
        end
      else
        controller.flash.keep
        redirect_to navigation_location
      end
    end

    def set_flash_message?
      return @force_redirect unless @force_redirect.nil?
      super
    end
  end
end