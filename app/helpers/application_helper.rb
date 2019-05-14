module ApplicationHelper
  include ActionView::Helpers::TagHelper

  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end

  def print_table_as_preformatted data, options={}
    content_tag :pre, TablePrint::Printer.new(data, options).table_print
  end
end
