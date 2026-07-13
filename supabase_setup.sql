-- ВНИМАНИЕ: пересоздаёт таблицу diary_entries и удаляет все текущие записи.
-- Нужно, чтобы данные одного человека за один день (ежедневно + чувства + задание)
-- хранились в одной строке, а не в трёх разных.
-- Выполнить в Supabase: SQL Editor → New query → вставить и Run.

drop table if exists diary_entries;

create table diary_entries (
  id text primary key,           -- дата + имя, например "2026-07-13::Айгуль Оспан"
  name text not null,
  entry_date date not null,
  created_at bigint not null,
  daily jsonb,                   -- заполняется вкладкой "Ежедневно"
  feelings jsonb,                -- заполняется вкладкой "Чувства"
  task jsonb                     -- заполняется вкладкой "Задание"
);

alter table diary_entries enable row level security;

-- Открытый доступ по ссылке (anon key): читать, создавать, дополнять и удалять записи.
create policy "diary public select" on diary_entries
  for select using (true);

create policy "diary public insert" on diary_entries
  for insert with check (true);

create policy "diary public update" on diary_entries
  for update using (true) with check (true);

create policy "diary public delete" on diary_entries
  for delete using (true);
