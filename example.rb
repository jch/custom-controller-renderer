require 'bundler/setup'
require 'action_pack'
require 'abstract_controller'

# This custom controller demonstrates how to create a controller
# with rendering capabilities that does not depend on HTTP.
# For a full introduction, see [this blog post](http://intridea.com/blog/).
class SearchRenderer < AbstractController::Base
  # If we were in Rails, we could add the following:

  # include Rails.application.routes.url_helpers  # rails route helpers
  # include Rails.application.helpers             # rails helpers under app/helpers

  # Add rendering mixins
  include AbstractController::Rendering
  include AbstractController::Logger

  # Setup templates and partials search path
  append_view_path File.expand_path "../app/views", __FILE__

  # Instance variables are available in the views,
  # so we save the variables we want to access in the views
  def initialize(search_results)
    @search_results = search_results
  end

  # running this action will render 'app/views/search\_renderer/foo.html.erb'
  # with @search\_results, and route helpers available in the views.
  def execute
    render :action => 'index'
  end
end

# Construct a SearchRenderer with some search results
renderer = SearchRenderer.new([
  "Doe, a deer, a female deer",
  "Ray, a drop of golden sun",
  "Mi, a name I call myself"
])

# Run the action `execute`
puts renderer.execute