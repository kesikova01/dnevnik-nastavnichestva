-- Выполнить один раз в Supabase: SQL Editor → New query → вставить и Run.
create table if not exists diary_entries (
  id text primary key,
  type text not null,
  name text not null,
  entry_date date not null,
  created_at bigint not null,
  data jsonb not null default '{}'::jsonb
);

alter table diary_entries enable row level security;

-- Открытый доступ на чтение/запись/удаление по ссылке (anon key).
-- Подходит для закрытой группы участников, у которых есть ссылка на сайт.
create policy "diary public select" on diary_entries
  for select using (true);

create policy "diary public insert" on diary_entries
  for insert with check (true);

create policy "diary public delete" on diary_entries
  for delete using (true);
