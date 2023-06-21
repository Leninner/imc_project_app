const String DEFAULT_ENV_VALUE = 'no_defined';

const SUPABASE_URL = String.fromEnvironment(
  "SUPABASE_URL",
  defaultValue: DEFAULT_ENV_VALUE,
);

const SUPABASE_ANON_KEY = String.fromEnvironment(
  "SUPABASE_ANON_KEY",
  defaultValue: DEFAULT_ENV_VALUE,
);
