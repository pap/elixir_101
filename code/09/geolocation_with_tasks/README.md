GeolocationWithTasks
====================

Fetch dependencies

```elixir
mix deps.get
```

Run the app
```elixir
iex -S mix
```

Run geolocation sequentially (response order is always the same)
```elixir
iex(1)> Geolocator.sequential
```

Run geolocation concurrently (response order may change in each run)
```elixir
iex(2)> Geolocator.concurrent
```
