# supabase

## Modifying the Database Schema

1. Modify schemas/public.sql as needed.

2. Create a diff

    ```bash
    bunx supabase db diff -f <migration_name>
    ```

3. Reset the db to apply migrations and re-seed

    ```bash
    bunx supabase db reset
    ```