class ApplicationHelper::Button::MiqRequestApproval < ApplicationHelper::Button::MiqRequest
  needs :@showtype, :@record, :@request_tab

  def role_allows_feature?
    prefix = case @request_tab
             when 'ae', 'host'
               "#{@request_tab}_"
             else
               ""
             end
    # check RBAC on separate button
    role_allows?(:feature => "#{prefix}miq_request_approval")
  end

  def visible?
    return false unless super
    return false if %w(approved denied).include?(@record.approval_state) || @showtype == "miq_provisions"
    true
  end
end
