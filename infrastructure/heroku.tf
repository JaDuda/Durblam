resource "heroku_app" "durblam" {
  name   = "durblam"
  region = "eu"

  buildpacks = [
    "heroku/gradle"
  ]
}

resource "heroku_addon" "durblam" {
  app_id = "heroku_app.durblam.id"
  plan   = "heroku-postgresql:hobby-dev"
}

resource "heroku_pipeline" "durblam" {
  name = "durblam-pipeline"
}

# Couple app to pipeline
resource "heroku_pipeline_coupling" "staging_pipeline_coupling" {
  app_id = heroku_app.durblam.id
  pipeline = heroku_pipeline.durblam.id
  stage = "staging"
}

// Add GitHub repository integration with the pipeline
resource "herokux_pipeline_github_integration" "pipeline_integration" {
  pipeline_id = heroku_pipeline.durblam.id
  org_repo = "JaDuda/Durblam"
}

// Add Heroku app GitHub integration
resource "herokux_app_github_integration" "durblam_gh_integration" {
  app_id = heroku_app.durblam.uuid
  branch = "master"
  auto_deploy = true
  wait_for_ci = true

  # Tells Terraform that this resource must be created/updated
  # only after the 'herokux_pipeline_github_integration' has been succesfully applied
  depends_on = [herokux_pipeline_github_integration.pipeline_integration]
}

