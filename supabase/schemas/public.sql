create table "profiles" (
    id uuid not null references auth.users on delete cascade,
    
    email varchar(255) not null,

    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone not null default now(),

    primary key (id)
);

alter table public.profiles enable row level security;

create policy "Users can view their own profile" on public.profiles for select using (auth.uid() = id);
create policy "Users can insert their own profile" on public.profiles for insert with check (auth.uid() = id);
create policy "Users can update their own profile" on public.profiles for update using (auth.uid() = id);
-- Does not allow client to delete a profile. This should be handled by the auth.users table on delete cascade.

create table "workouts" (
    id uuid not null default gen_random_uuid(),
    user_id uuid not null references auth.users on delete cascade,
    
    name varchar(255) not null,

    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone not null default now(),

    primary key (id)
);

alter table public.workouts enable row level security;

create policy "Users can view their own workouts" on public.workouts for select using (auth.uid() = user_id);
create policy "Users can insert their own workouts" on public.workouts for insert with check (auth.uid() = user_id);
create policy "Users can update their own workouts" on public.workouts for update using (auth.uid() = user_id);
create policy "Users can delete their own workouts" on public.workouts for delete using (auth.uid() = user_id);

-- Function to handle new user signups
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = ''
as $$
begin
  insert into public.profiles (id, email)
  values (new.id, new.email);
  return new;
end;
$$;

-- Trigger on auth.users
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();