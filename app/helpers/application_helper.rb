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

  def tp_pre data, options={}
    content_tag :pre, TablePrint::Printer.new(data, options).table_print
  end

  def with_captured_stdout
    original_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = original_stdout
  end
end
