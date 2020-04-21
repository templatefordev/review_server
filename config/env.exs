System.get_env("DATABASE_URL") ||
  raise """
  environment variable DATABASE_URL is missing.
  For example: ecto://USER:PASS@HOST/DATABASE
  """

System.get_env("SECRET_KEY_BASE") ||
  raise """
  environment variable SECRET_KEY_BASE is missing.
  You can generate one by calling: mix phx.gen.secret
  """
