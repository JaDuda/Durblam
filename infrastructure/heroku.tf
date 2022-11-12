resource "heroku_app" "durblam" {
  name   = "durblam"
  region = "eu"

  buildpacks = [
    "heroku/gradle"
  ]
}