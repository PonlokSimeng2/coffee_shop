-- ============================================================
-- Coffee Shop App — Supabase schema (run in SQL Editor)
-- UUID keys, linked to auth.users, RLS enabled everywhere
-- ============================================================

create extension if not exists "pgcrypto";

-- ---------- PROFILES (extends auth.users) ----------

create table public.profiles (
    user_id         uuid primary key references auth.users(id) on delete cascade,
    full_name       varchar(100) not null,
    avatar_url      text,
    loyalty_points  int not null default 0,
    points_goal     int not null default 200,
    created_at      timestamp not null default now()
);

-- Auto-create a profile row whenever someone signs up
create function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (user_id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', 'New user'));
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

create table public.loyalty_transactions (
    transaction_id  uuid primary key default gen_random_uuid(),
    user_id         uuid not null references public.profiles(user_id) on delete cascade,
    points_change   int not null,
    reason          varchar(100) not null,
    order_id        uuid,
    created_at      timestamp not null default now()
);

-- ---------- MENU: CATEGORIES & PRODUCTS ----------

create table public.categories (
    category_id     uuid primary key default gen_random_uuid(),
    name            varchar(50) not null unique,
    sort_order      int not null default 0
);

create table public.products (
    product_id      uuid primary key default gen_random_uuid(),
    category_id     uuid not null references public.categories(category_id),
    name            varchar(100) not null,
    short_description varchar(255),
    long_description   text,
    base_price      numeric(6,2) not null,
    image_url       text,
    is_customizable boolean not null default true,
    is_available    boolean not null default true,
    is_featured     boolean not null default false,
    is_editors_pick boolean not null default false,
    created_at      timestamp not null default now()
);

create table public.product_sizes (
    size_id         uuid primary key default gen_random_uuid(),
    product_id      uuid not null references public.products(product_id) on delete cascade,
    label           varchar(10) not null,
    price_delta     numeric(6,2) not null default 0,
    is_default      boolean not null default false
);

create table public.product_milk_options (
    milk_id         uuid primary key default gen_random_uuid(),
    product_id      uuid not null references public.products(product_id) on delete cascade,
    label           varchar(30) not null,
    price_delta     numeric(6,2) not null default 0,
    is_default      boolean not null default false
);

create table public.product_sweeteners (
    sweetener_id    uuid primary key default gen_random_uuid(),
    product_id      uuid not null references public.products(product_id) on delete cascade,
    label           varchar(30) not null,
    unit_price      numeric(6,2) not null default 0,
    max_qty         int not null default 5
);

-- ---------- LOCATIONS ----------

create table public.locations (
    location_id     uuid primary key default gen_random_uuid(),
    name            varchar(100) not null,
    address         varchar(255) not null,
    latitude        numeric(9,6),
    longitude       numeric(9,6),
    prep_time_min   int not null default 5,
    prep_time_max   int not null default 7,
    photo_url       text
);

-- ---------- PAYMENT METHODS ----------

create table public.payment_methods (
    payment_method_id uuid primary key default gen_random_uuid(),
    user_id         uuid not null references public.profiles(user_id) on delete cascade,
    card_brand      varchar(20) not null,
    last4           char(4) not null,
    is_default      boolean not null default false,
    created_at      timestamp not null default now()
);

-- ---------- CART / ORDERS ----------

create table public.orders (
    order_id        uuid primary key default gen_random_uuid(),
    user_id         uuid not null references public.profiles(user_id) on delete cascade,
    location_id     uuid references public.locations(location_id),
    payment_method_id uuid references public.payment_methods(payment_method_id),
    status          varchar(20) not null default 'cart'
                        check (status in ('cart','placed','preparing','ready','completed','cancelled')),
    subtotal        numeric(8,2) not null default 0,
    tax_and_fees    numeric(8,2) not null default 0,
    total           numeric(8,2) not null default 0,
    placed_at       timestamp,
    created_at      timestamp not null default now(),
    updated_at      timestamp not null default now()
);

alter table public.loyalty_transactions
    add constraint fk_loyalty_order foreign key (order_id) references public.orders(order_id);

create table public.order_items (
    order_item_id   uuid primary key default gen_random_uuid(),
    order_id        uuid not null references public.orders(order_id) on delete cascade,
    product_id      uuid not null references public.products(product_id),
    size_id         uuid references public.product_sizes(size_id),
    milk_id         uuid references public.product_milk_options(milk_id),
    quantity        int not null default 1 check (quantity > 0),
    unit_price      numeric(6,2) not null,
    line_total      numeric(8,2) not null,
    special_notes   varchar(255)
);

create table public.order_item_sweeteners (
    order_item_id   uuid not null references public.order_items(order_item_id) on delete cascade,
    sweetener_id    uuid not null references public.product_sweeteners(sweetener_id),
    quantity        int not null default 1,
    primary key (order_item_id, sweetener_id)
);

-- ---------- Indexes ----------

create index idx_products_category   on public.products(category_id);
create index idx_orders_user_status  on public.orders(user_id, status);
create index idx_order_items_order   on public.order_items(order_id);
create index idx_payment_user        on public.payment_methods(user_id);

-- ============================================================
-- Row Level Security
-- ============================================================

alter table public.profiles enable row level security;
alter table public.loyalty_transactions enable row level security;
alter table public.payment_methods enable row level security;
alter table public.orders enable row level security;
alter table public.order_items enable row level security;
alter table public.order_item_sweeteners enable row level security;
alter table public.categories enable row level security;
alter table public.products enable row level security;
alter table public.product_sizes enable row level security;
alter table public.product_milk_options enable row level security;
alter table public.product_sweeteners enable row level security;
alter table public.locations enable row level security;

-- Menu data: readable by anyone (including anon), writable by no one from the client
create policy "menu readable by all" on public.categories for select using (true);
create policy "menu readable by all" on public.products for select using (true);
create policy "menu readable by all" on public.product_sizes for select using (true);
create policy "menu readable by all" on public.product_milk_options for select using (true);
create policy "menu readable by all" on public.product_sweeteners for select using (true);
create policy "menu readable by all" on public.locations for select using (true);

-- Profiles: users manage only their own row
create policy "profile self select" on public.profiles for select using (auth.uid() = user_id);
create policy "profile self update" on public.profiles for update using (auth.uid() = user_id);

-- Payment methods: owner only
create policy "payment self all" on public.payment_methods for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Orders: owner only
create policy "orders self all" on public.orders for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Order items: via parent order's owner
create policy "order_items via order" on public.order_items for all
  using (exists (select 1 from public.orders o where o.order_id = order_items.order_id and o.user_id = auth.uid()))
  with check (exists (select 1 from public.orders o where o.order_id = order_items.order_id and o.user_id = auth.uid()));

create policy "sweeteners via order_item" on public.order_item_sweeteners for all
  using (exists (
    select 1 from public.order_items oi join public.orders o on o.order_id = oi.order_id
    where oi.order_item_id = order_item_sweeteners.order_item_id and o.user_id = auth.uid()))
  with check (exists (
    select 1 from public.order_items oi join public.orders o on o.order_id = oi.order_id
    where oi.order_item_id = order_item_sweeteners.order_item_id and o.user_id = auth.uid()));

create policy "loyalty self select" on public.loyalty_transactions for select using (auth.uid() = user_id);

-- ---------- RPC: atomically bump a user's loyalty point total ----------
-- Called from the Flutter app as supabase.rpc('increment_loyalty_points', ...)
-- after an order is placed, so concurrent orders can't race and clobber points.

create function public.increment_loyalty_points(p_user_id uuid, p_points int)
returns void as $$
begin
  update public.profiles
  set loyalty_points = loyalty_points + p_points
  where user_id = p_user_id;
end;
$$ language plpgsql security definer;

-- ---------- Seed menu data ----------

insert into public.categories (name, sort_order) values
  ('Espresso', 1), ('Brewed Coffee', 2), ('Signature', 3), ('Pastries', 4);

insert into public.products (category_id, name, short_description, long_description, base_price, is_editors_pick, is_featured)
select category_id, 'Caramel Macchiato', 'Rich espresso with steamed milk and a sweet caramel drizzle.',
  'A perfect blend of rich espresso, steamed milk, and a sweet caramel drizzle. Our signature espresso is layered with creamy milk and topped with a buttery caramel sauce for a deliciously smooth finish.',
  4.75, false, true
from public.categories where name = 'Espresso';

insert into public.products (category_id, name, short_description, base_price)
select category_id, 'Americano', 'Espresso shots topped with hot water create a light layer of crema.', 3.25
from public.categories where name = 'Espresso';

insert into public.products (category_id, name, short_description, base_price)
select category_id, 'Cappuccino', 'Dark, rich espresso under a smoothed and stretched layer of thick milk foam.', 4.25
from public.categories where name = 'Espresso';

insert into public.products (category_id, name, short_description, base_price)
select category_id, 'Classic Croissant', 'A flaky, buttery pastry perfect with any coffee.', 3.50
from public.categories where name = 'Pastries';

insert into public.products (category_id, name, short_description, base_price, is_editors_pick)
select category_id, 'Matcha Latte', 'Smooth & Creamy', 4.95, true
from public.categories where name = 'Signature';

insert into public.products (category_id, name, short_description, base_price, is_editors_pick)
select category_id, 'Butter Croissant', 'Freshly Baked', 3.75, true
from public.categories where name = 'Pastries';

insert into public.product_sizes (product_id, label, price_delta, is_default)
select product_id, 'S', 0.00, true from public.products where name = 'Caramel Macchiato'
union all
select product_id, 'M', 0.75, false from public.products where name = 'Caramel Macchiato'
union all
select product_id, 'L', 1.50, false from public.products where name = 'Caramel Macchiato';

insert into public.product_milk_options (product_id, label, price_delta, is_default)
select product_id, 'Dairy', 0.00, true from public.products where name = 'Caramel Macchiato'
union all
select product_id, 'Almond', 0.60, false from public.products where name = 'Caramel Macchiato'
union all
select product_id, 'Oat', 0.60, false from public.products where name = 'Caramel Macchiato';

insert into public.product_sweeteners (product_id, label, unit_price, max_qty)
select product_id, 'Sugar', 0.00, 5 from public.products where name = 'Caramel Macchiato';

insert into public.locations (name, address, prep_time_min, prep_time_max)
values ('The Daily Grind', '123 Coffee Bean Ln, Brewville', 5, 7);