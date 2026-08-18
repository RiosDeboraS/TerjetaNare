/*
# Create rsvps table (single-tenant, no auth)

1. New Tables
- `rsvps`
- `id` (uuid, primary key)
- `name` (text, not null) — nombre del invitado que confirma asistencia
- `created_at` (timestamptz, default now())
2. Security
- Enable RLS on `rsvps`.
- Allow anon + authenticated INSERT (los invitados confirman sin iniciar sesión) y SELECT.
- No UPDATE ni DELETE: una confirmación enviada no se edita ni se borra desde el frontend.
*/

CREATE TABLE IF NOT EXISTS rsvps (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE rsvps ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_insert_rsvps" ON rsvps;
CREATE POLICY "anon_insert_rsvps" ON rsvps FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_select_rsvps" ON rsvps;
CREATE POLICY "anon_select_rsvps" ON rsvps FOR SELECT
  TO anon, authenticated USING (true);