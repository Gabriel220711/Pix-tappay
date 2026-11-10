-- Execute este SQL no Supabase > SQL Editor.
create table if not exists public.lojas (
  slug text primary key,
  nome text not null,
  descricao text,
  chave_pix text,
  nome_recebedor text,
  cidade text default 'SAO PAULO',
  whatsapp text,
  instagram text,
  linkedin text,
  wifi_nome text,
  wifi_senha text,
  ativa boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.lojas enable row level security;

-- O site público só consegue consultar lojas ativas.
drop policy if exists "Public can read active stores" on public.lojas;
create policy "Public can read active stores"
on public.lojas for select
to anon, authenticated
using (ativa = true);

grant select on public.lojas to anon, authenticated;

-- Não crie política pública de INSERT, UPDATE ou DELETE.
-- Cadastre/edite os estabelecimentos pelo painel do Supabase (Table Editor).
