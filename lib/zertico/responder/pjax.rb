module Zertico
  class Responder
    module Pjax
      def default_render
        if request.headers['X-PJAX']
          render :layout => false
        else
          super
        end
      end
    end
  end
end