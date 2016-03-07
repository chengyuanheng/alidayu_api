module Alidayu
  module Sms
    class << self
      include Alidayu::Helper

      METHOD_HASH = {
        sms_send: "alibaba.aliqin.fc.sms.num.send",
        sms_query: "alibaba.aliqin.fc.sms.num.query"
      }

      # 短信发送
      # { mobiles: '', template_code: '', params: { code: '', product: '' } }
      def send(params)
        params[:method] = METHOD_HASH[:sms_send]
        params[:sms_type] = 'normal'
        params[:sms_free_sign_name] = params.delete(:sign_name) || Alidayu.config.sign_name
        if params[:params].is_a? Hash
          sms_param = params[:params].to_json
          params.delete(:params)
          params[:sms_param] = sms_param
        end
        params[:rec_num] = params.delete(:mobiles)
        params[:sms_template_code] = params.delete(:template_code)

        response = get_response(params)
      end

      # 短信发送记录查询
      # {  mobile: '', query_date: 'yyyyMMdd', current_page: 1, page_size: 20 }
      def query(params)
        params[:method] = METHOD_HASH[:sms_query]
        params[:rec_num] = params.delete(:mobile)

        response = get_response(params)
      end

    end
  end
end