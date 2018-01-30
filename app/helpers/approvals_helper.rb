module ApprovalsHelper

  def show_view_row_helper(label, content)
    content_tag :tr do
      (content_tag :th, label) + (content_tag :td, content, class: "text-right")
    end
  end
  
end
