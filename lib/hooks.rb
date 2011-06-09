module RedmineSprints
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_form_details_bottom, :partial => 'issue_sprints/user_story_field'
    render_on :view_issues_show_details_bottom, :partial => "issue_sprints/redirect_after_create"

    def controller_issues_new_before_save(context = {})
      issue = context[:issue]
      issue.user_story_id = context[:params][:issue][:user_story_id]
      if issue.id && issue.user_story_id && issue.fixed_version_id
        issue.redirect_to = url_for(:controller => :sprints, :action => "show", :id => issue.fixed_version_id, :project_id => issue.project.identifier) + "/" + issue.id
      end
    end
  end
end
