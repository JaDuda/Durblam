resource "heroku_app" "Durblam" {
  name   = "Durblam"
  region = "eu"

  buildpacks = [
    "heroku/gradle"
  ]
}