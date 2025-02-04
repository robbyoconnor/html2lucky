database = "html2lucky_#{Lucky::Env.name}"

LuckyRecord::Repo.configure do |settings|
  if Lucky::Env.production?
    settings.url = ENV.fetch("DATABASE_URL")
  else
    settings.url = ENV["DATABASE_URL"]? || LuckyRecord::PostgresURL.build(
      database: database,
      hostname: ENV["DB_HOST"]? || "localhost",
      username: ENV["DB_USERNAME"]? || "postgres",
      password: ENV["DB_PASSWORD"]? || "postgres"
    )
  end
  # In development and test, raise an error if you forget to preload associations
  settings.lazy_load_enabled = Lucky::Env.production?
end
