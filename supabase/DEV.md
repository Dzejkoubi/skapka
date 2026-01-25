
== Generate database types

This creates `database.types.ts`:

```
supabase gen types > database.types.ts
```

== Pull remote database

```
supabase db pull
supabase db dump --data-only > supabase/seed.sql
supabase db reset
```