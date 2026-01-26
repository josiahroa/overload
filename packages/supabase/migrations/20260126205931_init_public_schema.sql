
  create table "public"."profiles" (
    "id" uuid not null,
    "email" character varying(255) not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
      );


alter table "public"."profiles" enable row level security;


  create table "public"."workouts" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "name" character varying(255) not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
      );


alter table "public"."workouts" enable row level security;

CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (id);

CREATE UNIQUE INDEX workouts_pkey ON public.workouts USING btree (id);

alter table "public"."profiles" add constraint "profiles_pkey" PRIMARY KEY using index "profiles_pkey";

alter table "public"."workouts" add constraint "workouts_pkey" PRIMARY KEY using index "workouts_pkey";

alter table "public"."profiles" add constraint "profiles_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_id_fkey";

alter table "public"."workouts" add constraint "workouts_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."workouts" validate constraint "workouts_user_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
begin
  insert into public.profiles (id, email)
  values (new.id, new.email);
  return new;
end;
$function$
;

grant delete on table "public"."profiles" to "anon";

grant insert on table "public"."profiles" to "anon";

grant references on table "public"."profiles" to "anon";

grant select on table "public"."profiles" to "anon";

grant trigger on table "public"."profiles" to "anon";

grant truncate on table "public"."profiles" to "anon";

grant update on table "public"."profiles" to "anon";

grant delete on table "public"."profiles" to "authenticated";

grant insert on table "public"."profiles" to "authenticated";

grant references on table "public"."profiles" to "authenticated";

grant select on table "public"."profiles" to "authenticated";

grant trigger on table "public"."profiles" to "authenticated";

grant truncate on table "public"."profiles" to "authenticated";

grant update on table "public"."profiles" to "authenticated";

grant delete on table "public"."profiles" to "service_role";

grant insert on table "public"."profiles" to "service_role";

grant references on table "public"."profiles" to "service_role";

grant select on table "public"."profiles" to "service_role";

grant trigger on table "public"."profiles" to "service_role";

grant truncate on table "public"."profiles" to "service_role";

grant update on table "public"."profiles" to "service_role";

grant delete on table "public"."workouts" to "anon";

grant insert on table "public"."workouts" to "anon";

grant references on table "public"."workouts" to "anon";

grant select on table "public"."workouts" to "anon";

grant trigger on table "public"."workouts" to "anon";

grant truncate on table "public"."workouts" to "anon";

grant update on table "public"."workouts" to "anon";

grant delete on table "public"."workouts" to "authenticated";

grant insert on table "public"."workouts" to "authenticated";

grant references on table "public"."workouts" to "authenticated";

grant select on table "public"."workouts" to "authenticated";

grant trigger on table "public"."workouts" to "authenticated";

grant truncate on table "public"."workouts" to "authenticated";

grant update on table "public"."workouts" to "authenticated";

grant delete on table "public"."workouts" to "service_role";

grant insert on table "public"."workouts" to "service_role";

grant references on table "public"."workouts" to "service_role";

grant select on table "public"."workouts" to "service_role";

grant trigger on table "public"."workouts" to "service_role";

grant truncate on table "public"."workouts" to "service_role";

grant update on table "public"."workouts" to "service_role";


  create policy "Users can insert their own profile"
  on "public"."profiles"
  as permissive
  for insert
  to public
with check ((auth.uid() = id));



  create policy "Users can update their own profile"
  on "public"."profiles"
  as permissive
  for update
  to public
using ((auth.uid() = id));



  create policy "Users can view their own profile"
  on "public"."profiles"
  as permissive
  for select
  to public
using ((auth.uid() = id));



  create policy "Users can delete their own workouts"
  on "public"."workouts"
  as permissive
  for delete
  to public
using ((auth.uid() = user_id));



  create policy "Users can insert their own workouts"
  on "public"."workouts"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "Users can update their own workouts"
  on "public"."workouts"
  as permissive
  for update
  to public
using ((auth.uid() = user_id));



  create policy "Users can view their own workouts"
  on "public"."workouts"
  as permissive
  for select
  to public
using ((auth.uid() = user_id));


CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


