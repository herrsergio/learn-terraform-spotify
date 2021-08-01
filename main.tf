terraform {
  required_providers {
    spotify = {
      version = "~> 0.1.9"
      source  = "conradludgate/spotify"
    }
  }
}

variable "spotify_api_key" {
  type = string
}

provider "spotify" {
  api_key = var.spotify_api_key
}

resource "spotify_playlist" "playlist" {
  name        = "My First Terraform Playlist"
  description = "This playlist was created by Terraform"
  public      = true

  tracks = flatten([
    data.spotify_search_track.blutengel.tracks[*].id,
    data.spotify_search_track.she_hates.tracks[*].id,
    data.spotify_search_track.molchat.tracks[*].id,
    data.spotify_search_track.rammstein.tracks[*].id
  ])
}

data "spotify_search_track" "blutengel" {
  artists = ["Blutengel"]
  limit   = 10
}

data "spotify_search_track" "she_hates" {
  artists = ["She hates emotions"]
  limit   = 10
}

data "spotify_search_track" "rammstein" {
  artists = ["Rammstein"]
  limit   = 10
}

data "spotify_search_track" "molchat" {
  artists = ["Molchat Doma"]
  limit   = 10
}

output "tracks" {
  value = data.spotify_search_track.blutengel.tracks
}

