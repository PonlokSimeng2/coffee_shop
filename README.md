Phase 1 — Auth (phone/OTP)

Enable Phone provider in Supabase → Authentication → Providers, and connect an SMS provider (Twilio/MessageBird/Vonage).
Confirm handle_new_user() trigger doesn't require an email column, only user_id + full_name.
In Flutter, drop your Supabase URL/anon key into supabase_config.dart.
Replace auth_service.dart and login_screen.dart with the phone/OTP versions (send code → verify code → session).
Test: sign up with a real phone number, confirm a profiles row appears in Supabase automatically.
Test with a second number to confirm RLS isolates each user's data (place an order on one, confirm the other can't see it).

Phase 2 — Menu browsing

Confirm your seeded categories/products/product_sizes/product_milk_options/product_sweeteners rows exist in Table Editor.
Run the app — Home screen should load your profile greeting, featured product banner, and editor's picks by querying Supabase directly.
Tap into Menu — confirm category tabs switch product lists, and search hits ilike against products.name.
Tap a product — confirm size/milk/sweetener chips load from the nested Postgrest query and the live price updates as you change them.

Phase 3 — Cart

Add a few items from different products — confirm they appear in the Order tab with correct variant summaries and line totals.
Adjust quantities and remove items — confirm subtotal/tax/total recalculate live (cart is local state only at this point, nothing writes to Supabase yet).

Phase 4 — Checkout & orders

Seed at least one row in locations and one payment_methods row for your test user (via SQL Editor is fastest while testing).
Open Checkout — confirm pickup location and payment method both populate and are selectable.
Tap Confirm & Pay — confirm a new row appears in orders (status placed) and matching rows in order_items/order_item_sweeteners.
Confirm loyalty_transactions gets a new row and profiles.loyalty_points increments by the RPC call — check Home reflects the new point total.

Phase 5 — Replace the stubs

Payment: wire the "Add New Card" button to a real payment SDK (Stripe is the common choice) instead of the placeholder onPressed: () {}. Tokenize the card client-side, store only the token/last4/brand in payment_methods, and charge server-side (Supabase Edge Function) at checkout — never charge directly from the Flutter client.
Tax/fees: replace the flat 8.85% estimate in CartProvider with your real calculation, ideally computed in a Postgres function or Edge Function so it can't be spoofed client-side.
Order status: subscribe to Supabase Realtime on the orders table filtered by the current order id, so the Order tab can show preparing → ready → completed live instead of staying static after checkout.

Phase 6 — Profile completion

Add a short "what's your name?" screen shown once after first phone verification, writing to profiles.full_name — otherwise Home stays stuck on "New user."

Phase 7 — Polish

Replace placeholder image_url values with real product photos uploaded to Supabase Storage.
Pass over spacing/typography to match your actual brand rather than the mockup's default palette.
Add empty/error states (no network, empty cart already handled, failed OTP already handled — check failed order placement shows a clear retry path).

Phase 8 — Pre-launch checks

Re-run the two-account RLS test now that real payments and order status are wired in — confirm nothing leaks.
Turn "Confirm email"-equivalent protections back on if you loosened anything for testing (e.g. remove any temporary bypasses in RLS policies you added for debugging).
flutter analyze clean, then test on both iOS and Android physical devices, not just simulators — SMS delivery and phone number formatting behave differently on real hardware.

Phase 9 — Ship it

flutter build appbundle (Android) / flutter build ipa (iOS).
Submit to Play Store / App Store, each with their own review process for apps handling payments — expect additional disclosure requirements (privacy policy, payment terms) at submission.
