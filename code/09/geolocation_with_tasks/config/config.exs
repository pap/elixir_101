use Mix.Config

config :geolix,
  databases: [
    %{
      id: :country,
      adapter: Geolix.Adapter.MMDB2,
      source: "./geo_db/GeoLite2-Country.mmdb"
    }
  ]
