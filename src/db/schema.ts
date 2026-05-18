/**
 * ═══════════════════════════════════════════════════════════════════
 *  RESTROS — Complete Database Schema
 *  Multi-tenant Restaurant Operating System
 *  Built with Drizzle ORM + PostgreSQL
 *
 *  Architecture: 18 Layers
 *  Layer 1  — SaaS Core (Plans, Tenants, Subscriptions, Billing)
 *  Layer 2  — Tenant Structure (Brands, Locations, Settings, Hours)
 *  Layer 3  — Staff & Access (Users, Roles, Sessions, API Keys)
 *  Layer 4  — Menu System (Menus, Categories, Items, Modifiers, Pricing)
 *  Layer 5  — Customer Platform (Profiles, Addresses, Auth)
 *  Layer 6  — Loyalty & Wallet (Points, Wallet, Referrals)
 *  Layer 7  — Ordering Channels (QR, Kiosk, WhatsApp, Group, Cart)
 *  Layer 8  — Orders (Discounts, Delivery Zones, Orders, Items)
 *  Layer 9  — Delivery (Drivers, Deliveries, Tracking)
 *  Layer 10 — Payments & Refunds
 *  Layer 11 — Promotions & Coupons
 *  Layer 12 — Aggregator Integrations
 *  Layer 13 — Notifications
 *  Layer 14 — Reservations
 *  Layer 15 — Tax Compliance (FBR/SRB Pakistan + MENA)
 *  Layer 16 — AI & Intelligence (Demand, Upsell, Churn, Benchmarks)
 *  Layer 17 — Inventory & Procurement
 *  Layer 18 — Ratings, Audit & Compliance
 * ═══════════════════════════════════════════════════════════════════
 */

import { relations } from 'drizzle-orm';
import { primaryKey } from 'drizzle-orm/pg-core';
import {
  AnyPgColumn,
  boolean,
  date,
  decimal,
  index,
  integer,
  jsonb,
  pgEnum,
  pgTable,
  smallint,
  text,
  time,
  timestamp,
  uniqueIndex,
  uuid,
  varchar,
} from 'drizzle-orm/pg-core';

/* ═══════════════════════════════════════════════════════════════════
   ENUMS — All enums defined first
═══════════════════════════════════════════════════════════════════ */

export const subscriptionStatusEnum = pgEnum('subscription_status', [
  'trialing',
  'active',
  'past_due',
  'paused',
  'cancelled',
]);

export const billingCycleEnum = pgEnum('billing_cycle', ['monthly', 'annual']);

export const tenantStatusEnum = pgEnum('tenant_status', [
  'trial',
  'active',
  'suspended',
  'cancelled',
]);

export const locationStatusEnum = pgEnum('location_status', [
  'active',
  'inactive',
  'coming_soon',
  'permanently_closed',
]);

export const locationTypeEnum = pgEnum('location_type', [
  'dine_in',
  'cloud_kitchen',
  'kiosk_only',
  'pickup_only',
  'delivery_only',
  'hybrid',
  'food_truck',
  'drive_thru',
]);

export const orderTypeEnum = pgEnum('order_type', [
  'dine_in',
  'takeaway',
  'delivery',
  'catering',
]);

export const orderSourceEnum = pgEnum('order_source', [
  'pos',
  'online',
  'qr',
  'kiosk',
  'whatsapp',
  'aggregator',
  'group',
]);

export const orderStatusEnum = pgEnum('order_status', [
  'pending',
  'confirmed',
  'preparing',
  'ready',
  'out_for_delivery',
  'delivered',
  'completed',
  'cancelled',
  'rejected',
  'scheduled',
]);

export const paymentStatusEnum = pgEnum('payment_status', [
  'unpaid',
  'partial',
  'paid',
  'refunded',
  'partially_refunded',
  'failed',
]);

export const paymentMethodEnum = pgEnum('payment_method', [
  'cash',
  'card',
  'jazzcash',
  'easypaisa',
  'nayapay',
  'sadapay',
  'bank_transfer',
  'wallet',
  'loyalty',
  'complementary',
]);

export const paymentGatewayEnum = pgEnum('payment_gateway', [
  'manual',
  'stripe',
  'checkout',
  'jazzcash',
  'easypaisa',
  'internal_wallet',
]);

export const actorTypeEnum = pgEnum('actor_type', [
  'user',
  'customer',
  'driver',
  'system',
  'aggregator',
]);

export const notificationChannelEnum = pgEnum('notification_channel', [
  'sms',
  'email',
  'push',
  'whatsapp',
  'in_app',
]);

export const notificationStatusEnum = pgEnum('notification_status', [
  'pending',
  'sent',
  'delivered',
  'failed',
  'skipped',
]);

export const deliveryStatusEnum = pgEnum('delivery_status', [
  'pending',
  'assigned',
  'accepted',
  'picked_up',
  'en_route',
  'delivered',
  'failed',
  'returned',
]);

export const driverStatusEnum = pgEnum('driver_status', [
  'offline',
  'available',
  'on_delivery',
  'break',
]);

export const reservationStatusEnum = pgEnum('reservation_status', [
  'pending',
  'confirmed',
  'seated',
  'completed',
  'cancelled',
  'no_show',
]);

export const qrTypeEnum = pgEnum('qr_type', [
  'table',
  'pickup_counter',
  'takeaway',
  'menu_only',
]);

export const discountTypeEnum = pgEnum('discount_type', [
  'percentage',
  'fixed_amount',
  'free_item',
  'bogo',
]);

export const menuStatusEnum = pgEnum('menu_status', [
  'draft',
  'published',
  'archived',
]);

export const orderItemStatusEnum = pgEnum('order_item_status', [
  'pending',
  'preparing',
  'ready',
  'served',
  'cancelled',
  'voided',
]);

export const roleScopeEnum = pgEnum('role_scope', [
  'tenant',
  'location',
  'brand',
]);

export const taxTypeEnum = pgEnum('tax_type', [
  'gst',
  'service_tax',
  'fbr_pos',
  'srb',
  'vat',
  'zatca',
  'custom',
]);

export const changeTypeEnum = pgEnum('change_type', [
  'upgrade',
  'downgrade',
  'trial_to_paid',
  'cancel',
  'reactivate',
]);

export const loyaltyTransactionTypeEnum = pgEnum('loyalty_transaction_type', [
  'earn',
  'redeem',
  'expire',
  'adjust',
  'refund',
]);

export const walletTransactionTypeEnum = pgEnum('wallet_transaction_type', [
  'topup',
  'spend',
  'refund',
  'adjust',
  'expire',
]);

export const auditActionEnum = pgEnum('audit_action', [
  'create',
  'update',
  'delete',
  'login',
  'logout',
  'export',
  'void',
  'refund',
]);

export const sentimentEnum = pgEnum('sentiment', [
  'positive',
  'neutral',
  'negative',
]);

export const groupSessionStatusEnum = pgEnum('group_session_status', [
  'open',
  'locked',
  'ordered',
  'expired',
  'cancelled',
]);

export const fbrStatusEnum = pgEnum('fbr_status', [
  'pending',
  'transmitted',
  'accepted',
  'failed',
  'not_applicable',
]);

export const menuSyncStatusEnum = pgEnum('menu_sync_status', [
  'pending',
  'synced',
  'failed',
  'out_of_sync',
]);

export const selectionTypeEnum = pgEnum('selection_type', [
  'single',
  'multiple',
  'exactly',
]);

export const invoiceStatusEnum = pgEnum('invoice_status', [
  'draft',
  'open',
  'paid',
  'void',
  'uncollectible',
]);

export const refundStatusEnum = pgEnum('refund_status', [
  'pending',
  'processing',
  'succeeded',
  'failed',
]);

export const refundMethodEnum = pgEnum('refund_method', [
  'original_payment',
  'wallet',
  'cash',
]);

export const authProviderEnum = pgEnum('auth_provider', [
  'email',
  'google',
  'apple',
  'phone',
]);

export const vehicleTypeEnum = pgEnum('vehicle_type', [
  'motorcycle',
  'bicycle',
  'car',
  'van',
  'foot',
]);

export const platformRoleEnum = pgEnum('platform_role', [
  'super_admin',
  'support',
]);

export const aiSuggestionTypeEnum = pgEnum('ai_suggestion_type', [
  'upsell_pair',
  'reorder_prompt',
  'win_back_offer',
  'price_optimization',
  'bundle_suggestion',
]);

export const inventoryTransactionTypeEnum = pgEnum(
  'inventory_transaction_type',
  ['received', 'consumed', 'wasted', 'adjusted', 'transferred'],
);

export const supplierStatusEnum = pgEnum('supplier_status', [
  'active',
  'inactive',
  'on_hold',
]);

export const referralStatusEnum = pgEnum('referral_status', [
  'pending',
  'converted',
  'rewarded',
  'expired',
]);

export const outboxStatusEnum = pgEnum('outbox_status', [
  'pending',
  'published',
  'failed',
]);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 1 — SAAS CORE
   Plans, Tenants, Subscriptions, Billing, Platform Users
═══════════════════════════════════════════════════════════════════ */

export const plans = pgTable(
  'plans',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    name: varchar('name', { length: 100 }).notNull(),
    slug: varchar('slug', { length: 120 }).notNull(),
    description: text('description'),
    monthlyPrice: decimal('monthly_price', { precision: 12, scale: 2 }),
    annualPrice: decimal('annual_price', { precision: 12, scale: 2 }),
    // Hard limits (null = unlimited)
    maxLocations: integer('max_locations'),
    maxUsers: integer('max_users'),
    maxTerminals: integer('max_terminals'),
    maxMenuItems: integer('max_menu_items'),
    maxBrands: integer('max_brands'),
    maxOrdersPerMonth: integer('max_orders_per_month'),
    // Permission ceiling — intersected with feature flags at runtime
    permissionCap: jsonb('permission_cap').$type<Record<string, unknown>>(),
    trialDays: integer('trial_days').default(14).notNull(),
    isActive: boolean('is_active').default(true).notNull(),
    displayOrder: integer('display_order').default(0).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    slugUk: uniqueIndex('plans_slug_uk').on(t.slug),
  }),
);

export const tenants = pgTable(
  'tenants',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    planId: uuid('plan_id').references(() => plans.id),
    businessName: varchar('business_name', { length: 255 }).notNull(),
    slug: varchar('slug', { length: 120 }).notNull(),
    status: tenantStatusEnum('status').notNull().default('trial'),
    billingEmail: varchar('billing_email', { length: 255 }).notNull(),
    billingName: varchar('billing_name', { length: 255 }),
    taxId: varchar('tax_id', { length: 100 }),
    ntnNumber: varchar('ntn_number', { length: 100 }),
    phone: varchar('phone', { length: 50 }),
    countryCode: varchar('country_code', { length: 10 })
      .default('PK')
      .notNull(),
    defaultTimezone: varchar('default_timezone', { length: 100 })
      .default('Asia/Karachi')
      .notNull(),
    defaultCurrency: varchar('default_currency', { length: 10 })
      .default('PKR')
      .notNull(),
    defaultLanguage: varchar('default_language', { length: 10 })
      .default('en')
      .notNull(),
    // Denormalised counters — updated via triggers/jobs, NOT on every write
    cachedLocationCount: integer('cached_location_count').default(0).notNull(),
    cachedOrderCountThisMonth: integer('cached_order_count_this_month')
      .default(0)
      .notNull(),
    // Feature usage snapshot — updated nightly by analytics job, used for upsell nudges
    featureUsageSnapshot: jsonb('feature_usage_snapshot').$type<
      Record<string, unknown>
    >(),
    isTestAccount: boolean('is_test_account').default(false).notNull(),
    isActive: boolean('is_active').default(true).notNull(),
    trialEndsAt: timestamp('trial_ends_at', { withTimezone: true }),
    activatedAt: timestamp('activated_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    slugUk: uniqueIndex('tenants_slug_uk').on(t.slug),
    billingEmailUk: uniqueIndex('tenants_billing_email_uk').on(t.billingEmail),
    planIdx: index('tenants_plan_idx').on(t.planId),
    statusIdx: index('tenants_status_idx').on(t.status),
  }),
);

export const subscriptions = pgTable(
  'subscriptions',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id, { onDelete: 'restrict' }),
    planId: uuid('plan_id').references(() => plans.id),
    status: subscriptionStatusEnum('status').notNull(),
    billingCycle: billingCycleEnum('billing_cycle').notNull(),
    baseAmount: decimal('base_amount', { precision: 12, scale: 2 }),
    discountAmount: decimal('discount_amount', {
      precision: 12,
      scale: 2,
    }).default('0'),
    finalAmount: decimal('final_amount', { precision: 12, scale: 2 }),
    currency: varchar('currency', { length: 10 }).default('PKR').notNull(),
    paymentGatewayRef: varchar('payment_gateway_ref', { length: 255 }),
    trialEndsAt: date('trial_ends_at'),
    currentPeriodStart: date('current_period_start'),
    currentPeriodEnd: date('current_period_end'),
    cancelledAt: date('cancelled_at'),
    cancellationReason: text('cancellation_reason'),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('subscriptions_tenant_idx').on(t.tenantId),
    planIdx: index('subscriptions_plan_idx').on(t.planId),
    statusIdx: index('subscriptions_status_idx').on(t.status),
    gatewayRefUk: uniqueIndex('subscriptions_gateway_ref_uk').on(
      t.paymentGatewayRef,
    ),
  }),
);

export const subscriptionInvoices = pgTable(
  'subscription_invoices',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    subscriptionId: uuid('subscription_id')
      .notNull()
      .references(() => subscriptions.id),
    invoiceNumber: varchar('invoice_number', { length: 120 }).notNull(),
    subtotal: decimal('subtotal', { precision: 12, scale: 2 }),
    taxAmount: decimal('tax_amount', { precision: 12, scale: 2 }).default('0'),
    total: decimal('total', { precision: 12, scale: 2 }),
    amountPaid: decimal('amount_paid', { precision: 12, scale: 2 }).default(
      '0',
    ),
    currency: varchar('currency', { length: 10 }).default('PKR').notNull(),
    status: invoiceStatusEnum('status').notNull().default('draft'),
    paymentGatewayRef: varchar('payment_gateway_ref', { length: 255 }),
    dueDate: date('due_date'),
    paidAt: timestamp('paid_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    invoiceNumberUk: uniqueIndex('sub_invoices_number_uk').on(t.invoiceNumber),
    tenantIdx: index('sub_invoices_tenant_idx').on(t.tenantId),
    subscriptionIdx: index('sub_invoices_subscription_idx').on(
      t.subscriptionId,
    ),
  }),
);

export const planChangeLogs = pgTable(
  'plan_change_logs',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    oldPlanId: uuid('old_plan_id').references(() => plans.id),
    newPlanId: uuid('new_plan_id').references(() => plans.id),
    changeType: changeTypeEnum('change_type').notNull(),
    changedBy: uuid('changed_by').references(() => users.id),
    prorationAmount: decimal('proration_amount', { precision: 12, scale: 2 }),
    effectiveAt: timestamp('effective_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('plan_change_logs_tenant_idx').on(t.tenantId),
  }),
);

export const platformUsers = pgTable(
  'platform_users',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    email: varchar('email', { length: 255 }).notNull(),
    passwordHash: text('password_hash').notNull(),
    fullName: varchar('full_name', { length: 255 }).notNull(),
    role: platformRoleEnum('role').notNull().default('super_admin'),
    isActive: boolean('is_active').default(true).notNull(),
    lastLoginAt: timestamp('last_login_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    emailUk: uniqueIndex('platform_users_email_uk').on(t.email),
  }),
);

export const platformSessions = pgTable(
  'platform_sessions',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    platformUserId: uuid('platform_user_id')
      .notNull()
      .references(() => platformUsers.id, { onDelete: 'cascade' }),
    refreshTokenHash: varchar('refresh_token_hash', { length: 255 }).notNull(),
    ipAddress: varchar('ip_address', { length: 45 }),
    userAgent: text('user_agent'),
    rotatedAt: timestamp('rotated_at', { withTimezone: true }),
    revokedAt: timestamp('revoked_at', { withTimezone: true }),
    expiresAt: timestamp('expires_at', { withTimezone: true }).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    lastUsedAt: timestamp('last_used_at', { withTimezone: true }),
  },
  (t) => ({
    refreshHashUk: uniqueIndex('platform_sessions_refresh_hash_uk').on(
      t.refreshTokenHash,
    ),
    userIdx: index('platform_sessions_platform_user_idx').on(t.platformUserId),
    expiresAtIdx: index('platform_sessions_expires_at_idx').on(t.expiresAt),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 2 — TENANT STRUCTURE
   Brands → Locations → Settings / Hours
═══════════════════════════════════════════════════════════════════ */

export const brands = pgTable(
  'brands',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    name: varchar('name', { length: 255 }).notNull(),
    slug: varchar('slug', { length: 120 }).notNull(),
    logoUrl: text('logo_url'),
    bannerUrl: text('banner_url'),
    primaryColor: varchar('primary_color', { length: 7 }),
    secondaryColor: varchar('secondary_color', { length: 7 }),
    cuisineType: varchar('cuisine_type', { length: 100 }),
    description: text('description'),
    metaTitle: varchar('meta_title', { length: 255 }),
    metaDescription: text('meta_description'),
    // Custom domain for white-label online store
    customDomain: varchar('custom_domain', { length: 255 }),
    customDomainVerifiedAt: timestamp('custom_domain_verified_at', {
      withTimezone: true,
    }),
    isActive: boolean('is_active').default(true).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('brands_tenant_idx').on(t.tenantId),
    tenantSlugUk: uniqueIndex('brands_tenant_slug_uk').on(t.tenantId, t.slug),
    customDomainUk: uniqueIndex('brands_custom_domain_uk').on(t.customDomain),
  }),
);

export const locations = pgTable(
  'locations',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    brandId: uuid('brand_id').references(() => brands.id),
    name: varchar('name', { length: 255 }).notNull(),
    slug: varchar('slug', { length: 120 }).notNull(),
    code: varchar('code', { length: 100 }).notNull(),
    status: locationStatusEnum('status').notNull().default('active'),
    locationType: locationTypeEnum('location_type'),
    addressLine1: varchar('address_line1', { length: 255 }),
    addressLine2: varchar('address_line2', { length: 255 }),
    area: varchar('area', { length: 150 }),
    city: varchar('city', { length: 150 }),
    state: varchar('state', { length: 150 }),
    postalCode: varchar('postal_code', { length: 20 }),
    countryCode: varchar('country_code', { length: 10 })
      .default('PK')
      .notNull(),
    phone: varchar('phone', { length: 50 }),
    email: varchar('email', { length: 255 }),
    whatsappNumber: varchar('whatsapp_number', { length: 50 }),
    timezone: varchar('timezone', { length: 100 })
      .default('Asia/Karachi')
      .notNull(),
    currency: varchar('currency', { length: 10 }).default('PKR').notNull(),
    latitude: decimal('latitude', { precision: 10, scale: 7 }),
    longitude: decimal('longitude', { precision: 10, scale: 7 }),
    googleMapsUrl: text('google_maps_url'),
    googlePlaceId: varchar('google_place_id', { length: 255 }),
    fbrPosId: varchar('fbr_pos_id', { length: 100 }),
    srbRegistrationNumber: varchar('srb_registration_number', { length: 100 }),
    isActive: boolean('is_active').default(true).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantSlugUk: uniqueIndex('locations_tenant_slug_uk').on(
      t.tenantId,
      t.slug,
    ),
    tenantCodeUk: uniqueIndex('locations_tenant_code_uk').on(
      t.tenantId,
      t.code,
    ),
    tenantIdx: index('locations_tenant_idx').on(t.tenantId),
    brandIdx: index('locations_brand_idx').on(t.brandId),
    statusIdx: index('locations_status_idx').on(t.status),
  }),
);

export const locationSettings = pgTable(
  'location_settings',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id, { onDelete: 'cascade' }),
    // Ordering channels
    pickupEnabled: boolean('pickup_enabled').default(false).notNull(),
    deliveryEnabled: boolean('delivery_enabled').default(false).notNull(),
    dineInEnabled: boolean('dine_in_enabled').default(false).notNull(),
    qrOrderingEnabled: boolean('qr_ordering_enabled').default(false).notNull(),
    kioskOrderingEnabled: boolean('kiosk_ordering_enabled')
      .default(false)
      .notNull(),
    whatsappOrderingEnabled: boolean('whatsapp_ordering_enabled')
      .default(false)
      .notNull(),
    scheduledOrdersEnabled: boolean('scheduled_orders_enabled')
      .default(false)
      .notNull(),
    groupOrderingEnabled: boolean('group_ordering_enabled')
      .default(false)
      .notNull(),
    // Tips
    tipsEnabled: boolean('tips_enabled').default(false).notNull(),
    tipPctOption1: decimal('tip_pct_option1', { precision: 5, scale: 2 }),
    tipPctOption2: decimal('tip_pct_option2', { precision: 5, scale: 2 }),
    tipPctOption3: decimal('tip_pct_option3', { precision: 5, scale: 2 }),
    // Service charge
    serviceChargeEnabled: boolean('service_charge_enabled')
      .default(false)
      .notNull(),
    serviceChargeRate: decimal('service_charge_rate', {
      precision: 5,
      scale: 2,
    }),
    // Loyalty & wallet
    loyaltyEnabled: boolean('loyalty_enabled').default(false).notNull(),
    walletEnabled: boolean('wallet_enabled').default(false).notNull(),
    referralsEnabled: boolean('referrals_enabled').default(false).notNull(),
    // Tax compliance
    fbrEnabled: boolean('fbr_enabled').default(false).notNull(),
    fbrPosChargeRate: decimal('fbr_pos_charge_rate', {
      precision: 5,
      scale: 2,
    }),
    srbEnabled: boolean('srb_enabled').default(false).notNull(),
    srbRate: decimal('srb_rate', { precision: 5, scale: 2 }),
    taxInclusivePricing: boolean('tax_inclusive_pricing')
      .default(false)
      .notNull(),
    // Order constraints
    minPickupWaitMinutes: integer('min_pickup_wait_minutes').default(15),
    minDeliveryWaitMinutes: integer('min_delivery_wait_minutes').default(30),
    minOrderAmountPickup: decimal('min_order_amount_pickup', {
      precision: 12,
      scale: 2,
    }),
    minOrderAmountDelivery: decimal('min_order_amount_delivery', {
      precision: 12,
      scale: 2,
    }),
    minOrderAmountDineIn: decimal('min_order_amount_dine_in', {
      precision: 12,
      scale: 2,
    }),
    maxScheduleDaysAhead: integer('max_schedule_days_ahead').default(7),
    maxActiveOrders: integer('max_active_orders'),
    // Status controls
    isAcceptingOrders: boolean('is_accepting_orders').default(true).notNull(),
    isTemporarilyClosed: boolean('is_temporarily_closed')
      .default(false)
      .notNull(),
    temporarilyClosedMessage: text('temporarily_closed_message'),
    acceptingOrdersUntil: timestamp('accepting_orders_until', {
      withTimezone: true,
    }),
    // Branding & content
    receiptFooterText: text('receipt_footer_text'),
    orderingPageBannerUrl: text('ordering_page_banner_url'),
    orderingPageAnnouncement: text('ordering_page_announcement'),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    locationUk: uniqueIndex('location_settings_location_uk').on(t.locationId),
  }),
);

export const locationHours = pgTable(
  'location_hours',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id, { onDelete: 'cascade' }),
    dayOfWeek: smallint('day_of_week').notNull(), // 0=Sun … 6=Sat
    isClosed: boolean('is_closed').default(false).notNull(),
    openTime: time('open_time'),
    closeTime: time('close_time'),
    lastOrderTime: time('last_order_time'),
    deliveryStartTime: time('delivery_start_time'),
    deliveryEndTime: time('delivery_end_time'),
    pickupStartTime: time('pickup_start_time'),
    pickupEndTime: time('pickup_end_time'),
  },
  (t) => ({
    locationDayUk: uniqueIndex('location_hours_location_day_uk').on(
      t.locationId,
      t.dayOfWeek,
    ),
    locationIdx: index('location_hours_location_idx').on(t.locationId),
  }),
);

export const locationHolidayHours = pgTable(
  'location_holiday_hours',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id, { onDelete: 'cascade' }),
    holidayDate: date('holiday_date').notNull(),
    isClosed: boolean('is_closed').default(true).notNull(),
    openTime: time('open_time'),
    closeTime: time('close_time'),
    reason: varchar('reason', { length: 100 }),
  },
  (t) => ({
    locationDateUk: uniqueIndex('location_holiday_location_date_uk').on(
      t.locationId,
      t.holidayDate,
    ),
    locationIdx: index('location_holiday_hours_location_idx').on(t.locationId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 3 — STAFF & ACCESS
   Users, Roles, Sessions, API Keys
═══════════════════════════════════════════════════════════════════ */

export const roles = pgTable(
  'roles',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    name: varchar('name', { length: 100 }).notNull(),
    scope: roleScopeEnum('scope').notNull(),
    isSystemRole: boolean('is_system_role').default(false).notNull(),
    permissions: jsonb('permissions').notNull().default('{}'),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('roles_tenant_idx').on(t.tenantId),
    tenantNameUk: uniqueIndex('roles_tenant_name_uk').on(t.tenantId, t.name),
  }),
);

export const users = pgTable(
  'users',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    fullName: varchar('full_name', { length: 255 }).notNull(),
    email: varchar('email', { length: 255 }).notNull(),
    passwordHash: text('password_hash'),
    phone: varchar('phone', { length: 50 }),
    avatarUrl: text('avatar_url'),
    emailVerified: boolean('email_verified').default(false).notNull(),
    mfaEnabled: boolean('mfa_enabled').default(false).notNull(),
    mfaSecret: varchar('mfa_secret', { length: 255 }),
    isActive: boolean('is_active').default(true).notNull(),
    lastLoginAt: timestamp('last_login_at', { withTimezone: true }),
    passwordChangedAt: timestamp('password_changed_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    // Email unique per tenant — same email can exist across tenants
    tenantEmailUk: uniqueIndex('users_tenant_email_uk').on(t.tenantId, t.email),
    tenantIdx: index('users_tenant_idx').on(t.tenantId),
  }),
);

export const userSessions = pgTable(
  'user_sessions',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    userId: uuid('user_id')
      .notNull()
      .references(() => users.id, { onDelete: 'cascade' }),
    activeLocationId: uuid('active_location_id').references(() => locations.id),
    tokenHash: varchar('token_hash', { length: 255 }).notNull(),
    refreshTokenHash: varchar('refresh_token_hash', { length: 255 }),
    deviceType: varchar('device_type', { length: 30 }),
    deviceName: varchar('device_name', { length: 100 }),
    ipAddress: varchar('ip_address', { length: 45 }),
    userAgent: text('user_agent'),
    lastActiveAt: timestamp('last_active_at', { withTimezone: true }),
    expiresAt: timestamp('expires_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tokenHashUk: uniqueIndex('user_sessions_token_hash_uk').on(t.tokenHash),
    userIdx: index('user_sessions_user_idx').on(t.userId),
    expiresAtIdx: index('user_sessions_expires_at_idx').on(t.expiresAt),
  }),
);

export const passwordResetTokens = pgTable(
  'password_reset_tokens',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    userId: uuid('user_id')
      .notNull()
      .references(() => users.id, { onDelete: 'cascade' }),
    tokenHash: varchar('token_hash', { length: 255 }).notNull(),
    isUsed: boolean('is_used').default(false).notNull(),
    expiresAt: timestamp('expires_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tokenHashUk: uniqueIndex('password_reset_tokens_hash_uk').on(t.tokenHash),
    userIdx: index('password_reset_tokens_user_idx').on(t.userId),
  }),
);

export const userLocationAccess = pgTable(
  'user_location_access',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    userId: uuid('user_id')
      .notNull()
      .references(() => users.id, { onDelete: 'cascade' }),
    roleId: uuid('role_id')
      .notNull()
      .references(() => roles.id),
    locationId: uuid('location_id').references(() => locations.id),
    assignedAt: timestamp('assigned_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    expiresAt: timestamp('expires_at', { withTimezone: true }),
  },
  (t) => ({
    userRoleLocationUk: uniqueIndex('ula_user_role_location_uk').on(
      t.userId,
      t.roleId,
      t.locationId,
    ),
    userIdx: index('ula_user_idx').on(t.userId),
    roleIdx: index('ula_role_idx').on(t.roleId),
    locationIdx: index('ula_location_idx').on(t.locationId),
  }),
);

export const apiKeys = pgTable(
  'api_keys',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    createdBy: uuid('created_by').references(() => users.id),
    keyPrefix: varchar('key_prefix', { length: 10 }).notNull(),
    keyHash: varchar('key_hash', { length: 255 }).notNull(),
    name: varchar('name', { length: 255 }).notNull(),
    scopes: text('scopes').array(),
    isActive: boolean('is_active').default(true).notNull(),
    lastUsedAt: timestamp('last_used_at', { withTimezone: true }),
    expiresAt: timestamp('expires_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    keyHashUk: uniqueIndex('api_keys_key_hash_uk').on(t.keyHash),
    tenantIdx: index('api_keys_tenant_idx').on(t.tenantId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 4 — MENU SYSTEM
   Menus → Categories → Items → Modifiers → Pricing → Tax
═══════════════════════════════════════════════════════════════════ */

export const menus = pgTable(
  'menus',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    brandId: uuid('brand_id').references(() => brands.id),
    name: varchar('name', { length: 255 }).notNull(),
    status: menuStatusEnum('status').notNull().default('draft'),
    isDefault: boolean('is_default').default(false).notNull(),
    publishedAt: timestamp('published_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('menus_tenant_idx').on(t.tenantId),
    brandIdx: index('menus_brand_idx').on(t.brandId),
  }),
);

export const menuLocationAssignments = pgTable(
  'menu_location_assignments',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    menuId: uuid('menu_id')
      .notNull()
      .references(() => menus.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    daysActive: smallint('days_active').array(), // [0..6]
    availableFrom: time('available_from'),
    availableTo: time('available_to'),
    isActive: boolean('is_active').default(true).notNull(),
  },
  (t) => ({
    menuLocationUk: uniqueIndex('mla_menu_location_uk').on(
      t.menuId,
      t.locationId,
    ),
    menuIdx: index('mla_menu_idx').on(t.menuId),
    locationIdx: index('mla_location_idx').on(t.locationId),
  }),
);

export const menuCategories = pgTable(
  'menu_categories',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    menuId: uuid('menu_id')
      .notNull()
      .references(() => menus.id),
    parentId: uuid('parent_id').references(
      (): AnyPgColumn => menuCategories.id,
    ),
    name: varchar('name', { length: 255 }).notNull(),
    slug: varchar('slug', { length: 255 }).notNull(),
    description: text('description'),
    imageUrl: text('image_url'),
    displayOrder: integer('display_order').default(0).notNull(),
    isActive: boolean('is_active').default(true).notNull(),
    availableFrom: time('available_from'),
    availableTo: time('available_to'),
    availableOrderTypes: orderTypeEnum('available_order_types').array(),
    deletedAt: timestamp('deleted_at', { withTimezone: true }),
  },
  (t) => ({
    tenantIdx: index('menu_categories_tenant_idx').on(t.tenantId),
    menuIdx: index('menu_categories_menu_idx').on(t.menuId),
    parentIdx: index('menu_categories_parent_idx').on(t.parentId),
  }),
);

export const taxClasses = pgTable(
  'tax_classes',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    name: varchar('name', { length: 100 }).notNull(),
    rate: decimal('rate', { precision: 8, scale: 4 }).notNull(),
    jurisdiction: varchar('jurisdiction', { length: 100 }),
    taxType: taxTypeEnum('tax_type'),
    isInclusive: boolean('is_inclusive').default(false).notNull(),
    isActive: boolean('is_active').default(true).notNull(),
  },
  (t) => ({
    tenantIdx: index('tax_classes_tenant_idx').on(t.tenantId),
    tenantNameUk: uniqueIndex('tax_classes_tenant_name_uk').on(
      t.tenantId,
      t.name,
    ),
  }),
);

export const menuItems = pgTable(
  'menu_items',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    categoryId: uuid('category_id')
      .notNull()
      .references(() => menuCategories.id),
    taxClassId: uuid('tax_class_id').references(() => taxClasses.id),
    sku: varchar('sku', { length: 120 }).notNull(),
    name: varchar('name', { length: 255 }).notNull(),
    slug: varchar('slug', { length: 255 }).notNull(),
    description: text('description'),
    imageUrl: text('image_url'),
    thumbnailUrl: text('thumbnail_url'),
    tags: text('tags').array(),
    uom: varchar('uom', { length: 50 }).default('piece'),
    basePrice: decimal('base_price', { precision: 12, scale: 2 }).notNull(),
    compareAtPrice: decimal('compare_at_price', { precision: 12, scale: 2 }),
    discountPrice: decimal('discount_price', { precision: 12, scale: 2 }),
    prepTimeSeconds: integer('prep_time_seconds'),
    allergens: text('allergens').array(),
    dietaryTags: text('dietary_tags').array(), // ['halal','vegan','gluten_free']
    calories: integer('calories'),
    availableOrderTypes: orderTypeEnum('available_order_types').array(),
    isActive: boolean('is_active').default(true).notNull(),
    isEightySix: boolean('is_eighty_six').default(false).notNull(),
    isFeatured: boolean('is_featured').default(false).notNull(),
    isStockProduct: boolean('is_stock_product').default(false).notNull(),
    displayOrder: integer('display_order').default(0).notNull(),
    // AI-generated affinity score — updated nightly
    popularityScore: decimal('popularity_score', { precision: 8, scale: 4 }),
    deletedAt: timestamp('deleted_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantSkuUk: uniqueIndex('menu_items_tenant_sku_uk').on(t.tenantId, t.sku),
    tenantSlugUk: uniqueIndex('menu_items_tenant_slug_uk').on(
      t.tenantId,
      t.slug,
    ),
    tenantIdx: index('menu_items_tenant_idx').on(t.tenantId),
    categoryIdx: index('menu_items_category_idx').on(t.categoryId),
    taxClassIdx: index('menu_items_tax_class_idx').on(t.taxClassId),
    activeIdx: index('menu_items_active_idx').on(t.tenantId, t.categoryId),
  }),
);

export const menuItemLocationOverrides = pgTable(
  'menu_item_location_overrides',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    menuItemId: uuid('menu_item_id')
      .notNull()
      .references(() => menuItems.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    priceOverride: decimal('price_override', { precision: 12, scale: 2 }),
    discountPriceOverride: decimal('discount_price_override', {
      precision: 12,
      scale: 2,
    }),
    stockQuantity: integer('stock_quantity'),
    isAvailable: boolean('is_available').default(true).notNull(),
    isEightySix: boolean('is_eighty_six').default(false).notNull(),
    isInStock: boolean('is_in_stock').default(true).notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    itemLocationUk: uniqueIndex('milo_item_location_uk').on(
      t.menuItemId,
      t.locationId,
    ),
    menuItemIdx: index('milo_item_idx').on(t.menuItemId),
    locationIdx: index('milo_location_idx').on(t.locationId),
  }),
);

export const modifierGroups = pgTable(
  'modifier_groups',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    name: varchar('name', { length: 255 }).notNull(),
    selectionType: selectionTypeEnum('selection_type')
      .default('single')
      .notNull(),
    minSelections: integer('min_selections').default(0).notNull(),
    maxSelections: integer('max_selections'),
    isRequired: boolean('is_required').default(false).notNull(),
    displayOrder: integer('display_order').default(0).notNull(),
    deletedAt: timestamp('deleted_at', { withTimezone: true }),
  },
  (t) => ({
    tenantIdx: index('modifier_groups_tenant_idx').on(t.tenantId),
  }),
);

export const menuItemModifierGroups = pgTable(
  'menu_item_modifier_groups',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    menuItemId: uuid('menu_item_id')
      .notNull()
      .references(() => menuItems.id),
    modifierGroupId: uuid('modifier_group_id')
      .notNull()
      .references(() => modifierGroups.id),
    displayOrder: integer('display_order').default(0).notNull(),
  },
  (t) => ({
    itemGroupUk: uniqueIndex('mimgr_item_group_uk').on(
      t.menuItemId,
      t.modifierGroupId,
    ),
    menuItemIdx: index('mimgr_item_idx').on(t.menuItemId),
    groupIdx: index('mimgr_group_idx').on(t.modifierGroupId),
  }),
);

export const modifiers = pgTable(
  'modifiers',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    modifierGroupId: uuid('modifier_group_id')
      .notNull()
      .references(() => modifierGroups.id),
    name: varchar('name', { length: 255 }).notNull(),
    sku: varchar('sku', { length: 120 }),
    priceDelta: decimal('price_delta', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    caloriesDelta: integer('calories_delta'),
    displayOrder: integer('display_order').default(0).notNull(),
    isActive: boolean('is_active').default(true).notNull(),
    deletedAt: timestamp('deleted_at', { withTimezone: true }),
  },
  (t) => ({
    tenantIdx: index('modifiers_tenant_idx').on(t.tenantId),
    groupIdx: index('modifiers_group_idx').on(t.modifierGroupId),
  }),
);

export const modifierLocationOverrides = pgTable(
  'modifier_location_overrides',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    modifierId: uuid('modifier_id')
      .notNull()
      .references(() => modifiers.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    priceDeltaOverride: decimal('price_delta_override', {
      precision: 12,
      scale: 2,
    }),
    isAvailable: boolean('is_available').default(true).notNull(),
    isInStock: boolean('is_in_stock').default(true).notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    modifierLocationUk: uniqueIndex('mlo_modifier_location_uk').on(
      t.modifierId,
      t.locationId,
    ),
    modifierIdx: index('mlo_modifier_idx').on(t.modifierId),
    locationIdx: index('mlo_location_idx').on(t.locationId),
  }),
);

export const priceRules = pgTable(
  'price_rules',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id').references(() => locations.id),
    menuItemId: uuid('menu_item_id').references(() => menuItems.id),
    name: varchar('name', { length: 255 }).notNull(),
    ruleType: varchar('rule_type', { length: 50 }).notNull(), // 'happy_hour','surge','day_of_week'
    value: decimal('value', { precision: 12, scale: 2 }),
    daysOfWeek: smallint('days_of_week').array(),
    startTime: time('start_time'),
    endTime: time('end_time'),
    validFrom: date('valid_from'),
    validTo: date('valid_to'),
    isActive: boolean('is_active').default(true).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('price_rules_tenant_idx').on(t.tenantId),
    locationIdx: index('price_rules_location_idx').on(t.locationId),
    menuItemIdx: index('price_rules_menu_item_idx').on(t.menuItemId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 5 — CUSTOMER PLATFORM
   Profiles, Addresses, OTPs, Auth
═══════════════════════════════════════════════════════════════════ */

export const customers = pgTable(
  'customers',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    fullName: varchar('full_name', { length: 255 }),
    email: varchar('email', { length: 255 }),
    phone: varchar('phone', { length: 50 }).notNull(),
    passwordHash: text('password_hash'),
    authProvider: authProviderEnum('auth_provider').default('phone'),
    authProviderId: varchar('auth_provider_id', { length: 255 }),
    gender: varchar('gender', { length: 20 }),
    dateOfBirth: date('date_of_birth'),
    emailVerified: boolean('email_verified').default(false).notNull(),
    phoneVerified: boolean('phone_verified').default(false).notNull(),
    preferredLanguage: varchar('preferred_language', { length: 10 }).default(
      'en',
    ),
    marketingOptIn: boolean('marketing_opt_in').default(false).notNull(),
    smsOptIn: boolean('sms_opt_in').default(false).notNull(),
    whatsappOptIn: boolean('whatsapp_opt_in').default(false).notNull(),
    // IMPORTANT: These are read-only cache fields.
    // Source of truth is loyalty_account_balances and wallet_account_balances.
    cachedLoyaltyPoints: decimal('cached_loyalty_points', {
      precision: 12,
      scale: 2,
    })
      .default('0')
      .notNull(),
    cachedWalletBalance: decimal('cached_wallet_balance', {
      precision: 12,
      scale: 2,
    })
      .default('0')
      .notNull(),
    // Denormalised stats — updated async after each order
    totalOrders: integer('total_orders').default(0).notNull(),
    totalSpent: decimal('total_spent', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    customerSegment: varchar('customer_segment', { length: 30 }), // 'new','regular','vip','churned'
    lastOrderAt: timestamp('last_order_at', { withTimezone: true }),
    referralCode: varchar('referral_code', { length: 30 }),
    referredByCustomerId: uuid('referred_by_customer_id'),
    isActive: boolean('is_active').default(true).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantPhoneUk: uniqueIndex('customers_tenant_phone_uk').on(
      t.tenantId,
      t.phone,
    ),
    tenantIdx: index('customers_tenant_idx').on(t.tenantId),
    segmentIdx: index('customers_segment_idx').on(
      t.tenantId,
      t.customerSegment,
    ),
    referralCodeUk: uniqueIndex('customers_referral_code_uk').on(
      t.tenantId,
      t.referralCode,
    ),
  }),
);

export const customerAddresses = pgTable(
  'customer_addresses',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    customerId: uuid('customer_id')
      .notNull()
      .references(() => customers.id, { onDelete: 'cascade' }),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    label: varchar('label', { length: 50 }),
    fullName: varchar('full_name', { length: 255 }),
    phone: varchar('phone', { length: 50 }),
    addressLine1: varchar('address_line1', { length: 255 }),
    addressLine2: varchar('address_line2', { length: 255 }),
    landmark: varchar('landmark', { length: 255 }),
    area: varchar('area', { length: 150 }),
    city: varchar('city', { length: 150 }),
    state: varchar('state', { length: 150 }),
    postalCode: varchar('postal_code', { length: 20 }),
    countryCode: varchar('country_code', { length: 10 }).default('PK'),
    latitude: decimal('latitude', { precision: 10, scale: 7 }),
    longitude: decimal('longitude', { precision: 10, scale: 7 }),
    isDefault: boolean('is_default').default(false).notNull(),
    isActive: boolean('is_active').default(true).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    customerIdx: index('customer_addresses_customer_idx').on(t.customerId),
    tenantIdx: index('customer_addresses_tenant_idx').on(t.tenantId),
  }),
);

export const customerOtps = pgTable(
  'customer_otps',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    customerId: uuid('customer_id').references(() => customers.id),
    phone: varchar('phone', { length: 50 }).notNull(),
    channel: notificationChannelEnum('channel').notNull(),
    otpHash: varchar('otp_hash', { length: 255 }).notNull(),
    purpose: varchar('purpose', { length: 50 }).notNull(), // 'login','verify','reset'
    attempts: integer('attempts').default(0).notNull(),
    isUsed: boolean('is_used').default(false).notNull(),
    expiresAt: timestamp('expires_at', { withTimezone: true }).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('customer_otps_tenant_idx').on(t.tenantId),
    customerIdx: index('customer_otps_customer_idx').on(t.customerId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 6 — LOYALTY & WALLET
   Ledger-based balances (never update balance in place)
═══════════════════════════════════════════════════════════════════ */

export const loyaltyConfig = pgTable(
  'loyalty_config',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    isActive: boolean('is_active').default(false).notNull(),
    pointsPerCurrencyUnit: decimal('points_per_currency_unit', {
      precision: 12,
      scale: 4,
    })
      .notNull()
      .default('1'),
    pointRedemptionValue: decimal('point_redemption_value', {
      precision: 12,
      scale: 4,
    })
      .notNull()
      .default('0.01'),
    minRedeemPoints: integer('min_redeem_points').default(100),
    maxRedeemPctPerOrder: decimal('max_redeem_pct_per_order', {
      precision: 5,
      scale: 2,
    }).default('50'),
    pointsExpiryDays: integer('points_expiry_days'),
    earnOnDeliveryFee: boolean('earn_on_delivery_fee').default(false).notNull(),
    earnOnTax: boolean('earn_on_tax').default(false).notNull(),
    earnOnDiscountedOrders: boolean('earn_on_discounted_orders')
      .default(false)
      .notNull(),
    // Tier configuration (VIP levels)
    tiersEnabled: boolean('tiers_enabled').default(false).notNull(),
    tiersConfig: jsonb('tiers_config').$type<
      Array<{
        name: string;
        minPoints: number;
        multiplier: number;
        perks: string[];
      }>
    >(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantUk: uniqueIndex('loyalty_config_tenant_uk').on(t.tenantId),
  }),
);

/**
 * LEDGER TABLE — never UPDATE a row, only INSERT.
 * Balance = SUM(points) WHERE customerId = X AND expiresAt > NOW()
 * cachedLoyaltyPoints on customers is a read-optimised snapshot only.
 */
export const loyaltyLedger = pgTable(
  'loyalty_ledger',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    customerId: uuid('customer_id')
      .notNull()
      .references(() => customers.id),
    orderId: uuid('order_id').references(() => onlineOrders.id),
    type: loyaltyTransactionTypeEnum('type').notNull(),
    // Positive = earn, Negative = redeem/expire/adjust
    points: decimal('points', { precision: 12, scale: 2 }).notNull(),
    description: text('description'),
    expiresAt: timestamp('expires_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('loyalty_ledger_tenant_idx').on(t.tenantId),
    customerIdx: index('loyalty_ledger_customer_idx').on(t.customerId),
    orderIdx: index('loyalty_ledger_order_idx').on(t.orderId),
    expiryIdx: index('loyalty_ledger_expiry_idx').on(t.customerId, t.expiresAt),
  }),
);

/**
 * WALLET LEDGER — same append-only pattern as loyalty.
 * Balance = SUM(amount) WHERE customerId = X
 */
export const walletLedger = pgTable(
  'wallet_ledger',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    customerId: uuid('customer_id')
      .notNull()
      .references(() => customers.id),
    orderId: uuid('order_id').references(() => onlineOrders.id),
    type: walletTransactionTypeEnum('type').notNull(),
    // Positive = topup/refund, Negative = spend/expire
    amount: decimal('amount', { precision: 12, scale: 2 }).notNull(),
    description: varchar('description', { length: 255 }),
    referenceType: varchar('reference_type', { length: 50 }),
    referenceId: uuid('reference_id'),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('wallet_ledger_tenant_idx').on(t.tenantId),
    customerIdx: index('wallet_ledger_customer_idx').on(t.customerId),
    orderIdx: index('wallet_ledger_order_idx').on(t.orderId),
  }),
);

export const referralPrograms = pgTable(
  'referral_programs',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    isActive: boolean('is_active').default(false).notNull(),
    referrerRewardType: varchar('referrer_reward_type', { length: 20 }), // 'points','wallet','discount'
    referrerRewardValue: decimal('referrer_reward_value', {
      precision: 12,
      scale: 2,
    }),
    refereeRewardType: varchar('referee_reward_type', { length: 20 }),
    refereeRewardValue: decimal('referee_reward_value', {
      precision: 12,
      scale: 2,
    }),
    // Referee must place N orders before referrer is rewarded
    minRefereeOrders: integer('min_referee_orders').default(1).notNull(),
    maxReferralsPerCustomer: integer('max_referrals_per_customer'),
    programEndsAt: timestamp('program_ends_at', { withTimezone: true }),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantUk: uniqueIndex('referral_programs_tenant_uk').on(t.tenantId),
  }),
);

export const referrals = pgTable(
  'referrals',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    programId: uuid('program_id')
      .notNull()
      .references(() => referralPrograms.id),
    referrerCustomerId: uuid('referrer_customer_id')
      .notNull()
      .references(() => customers.id),
    refereeCustomerId: uuid('referee_customer_id').references(
      () => customers.id,
    ),
    referralCode: varchar('referral_code', { length: 30 }).notNull(),
    status: referralStatusEnum('status').notNull().default('pending'),
    refereeOrderCount: integer('referee_order_count').default(0).notNull(),
    rewardedAt: timestamp('rewarded_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('referrals_tenant_idx').on(t.tenantId),
    referrerIdx: index('referrals_referrer_idx').on(t.referrerCustomerId),
    codeIdx: index('referrals_code_idx').on(t.referralCode),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 7 — ORDERING CHANNELS
   QR, Kiosk, WhatsApp, Group, Scheduled, Cart
═══════════════════════════════════════════════════════════════════ */

export const qrCodes = pgTable(
  'qr_codes',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    qrType: qrTypeEnum('qr_type').notNull(),
    identifier: varchar('identifier', { length: 120 }).notNull(),
    tableNumber: varchar('table_number', { length: 50 }),
    tableLabel: varchar('table_label', { length: 100 }),
    tableCapacity: integer('table_capacity'),
    sectionName: varchar('section_name', { length: 100 }),
    qrImageUrl: text('qr_image_url'),
    shortUrl: varchar('short_url', { length: 255 }).notNull(),
    isActive: boolean('is_active').default(true).notNull(),
    totalScans: integer('total_scans').default(0).notNull(),
    lastScannedAt: timestamp('last_scanned_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    identifierUk: uniqueIndex('qr_codes_identifier_uk').on(t.identifier),
    shortUrlUk: uniqueIndex('qr_codes_short_url_uk').on(t.shortUrl),
    tenantIdx: index('qr_codes_tenant_idx').on(t.tenantId),
    locationIdx: index('qr_codes_location_idx').on(t.locationId),
  }),
);

export const kioskTerminals = pgTable(
  'kiosk_terminals',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    identifier: varchar('identifier', { length: 120 }).notNull(),
    name: varchar('name', { length: 255 }),
    status: varchar('status', { length: 30 }).notNull().default('active'),
    lastActiveAt: timestamp('last_active_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    identifierUk: uniqueIndex('kiosk_terminals_identifier_uk').on(t.identifier),
    tenantIdx: index('kiosk_terminals_tenant_idx').on(t.tenantId),
    locationIdx: index('kiosk_terminals_location_idx').on(t.locationId),
  }),
);

export const whatsappSessions = pgTable(
  'whatsapp_sessions',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    customerId: uuid('customer_id').references(() => customers.id),
    waPhoneNumber: varchar('wa_phone_number', { length: 50 }).notNull(),
    sessionState: varchar('session_state', { length: 50 }),
    cartData: jsonb('cart_data'),
    orderType: orderTypeEnum('order_type'),
    deliveryAddressId: uuid('delivery_address_id').references(
      () => customerAddresses.id,
    ),
    currentStep: varchar('current_step', { length: 100 }),
    lastMessageAt: timestamp('last_message_at', { withTimezone: true }),
    expiresAt: timestamp('expires_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('wa_sessions_tenant_idx').on(t.tenantId),
    locationIdx: index('wa_sessions_location_idx').on(t.locationId),
    customerIdx: index('wa_sessions_customer_idx').on(t.customerId),
  }),
);

export const groupOrderSessions = pgTable(
  'group_order_sessions',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    hostCustomerId: uuid('host_customer_id').references(() => customers.id),
    sessionToken: varchar('session_token', { length: 255 }).notNull(),
    shareLink: varchar('share_link', { length: 255 }).notNull(),
    status: groupSessionStatusEnum('status').notNull().default('open'),
    orderType: orderTypeEnum('order_type'),
    deliveryAddressId: uuid('delivery_address_id').references(
      () => customerAddresses.id,
    ),
    maxParticipants: integer('max_participants'),
    currentParticipants: integer('current_participants').default(0).notNull(),
    expiresAt: timestamp('expires_at', { withTimezone: true }),
    lockedAt: timestamp('locked_at', { withTimezone: true }),
    orderedAt: timestamp('ordered_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    sessionTokenUk: uniqueIndex('group_sessions_token_uk').on(t.sessionToken),
    shareLinkUk: uniqueIndex('group_sessions_share_link_uk').on(t.shareLink),
    tenantIdx: index('group_sessions_tenant_idx').on(t.tenantId),
    locationIdx: index('group_sessions_location_idx').on(t.locationId),
  }),
);

export const groupOrderParticipants = pgTable(
  'group_order_participants',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    sessionId: uuid('session_id')
      .notNull()
      .references(() => groupOrderSessions.id),
    customerId: uuid('customer_id').references(() => customers.id),
    participantName: varchar('participant_name', { length: 255 }),
    status: varchar('status', { length: 30 }).notNull().default('browsing'),
    cartItems: jsonb('cart_items'),
    subtotal: decimal('subtotal', { precision: 12, scale: 2 }),
    submittedAt: timestamp('submitted_at', { withTimezone: true }),
    joinedAt: timestamp('joined_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    sessionIdx: index('group_participants_session_idx').on(t.sessionId),
    customerIdx: index('group_participants_customer_idx').on(t.customerId),
  }),
);

export const scheduledOrderSlots = pgTable(
  'scheduled_order_slots',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    orderType: orderTypeEnum('order_type'),
    dayOfWeek: smallint('day_of_week').notNull(),
    slotTime: time('slot_time').notNull(),
    maxOrdersPerSlot: integer('max_orders_per_slot'),
    slotIntervalMinutes: integer('slot_interval_minutes').default(15),
    isActive: boolean('is_active').default(true).notNull(),
  },
  (t) => ({
    locationIdx: index('scheduled_slots_location_idx').on(t.locationId),
    locationDayUk: uniqueIndex('scheduled_slots_location_day_time_uk').on(
      t.locationId,
      t.dayOfWeek,
      t.slotTime,
      t.orderType,
    ),
  }),
);

export const cartSessions = pgTable(
  'cart_sessions',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    customerId: uuid('customer_id').references(() => customers.id),
    sessionToken: varchar('session_token', { length: 255 }).notNull(),
    orderSource: orderSourceEnum('order_source'),
    orderType: orderTypeEnum('order_type'),
    qrCodeId: uuid('qr_code_id').references(() => qrCodes.id),
    groupSessionId: uuid('group_session_id').references(
      () => groupOrderSessions.id,
    ),
    kioskTerminalId: uuid('kiosk_terminal_id').references(
      () => kioskTerminals.id,
    ),
    deliveryAddressId: uuid('delivery_address_id').references(
      () => customerAddresses.id,
    ),
    scheduledFor: timestamp('scheduled_for', { withTimezone: true }),
    cartItems: jsonb('cart_items').notNull().default('[]'),
    promoCode: varchar('promo_code', { length: 100 }),
    appliedReferralCode: varchar('applied_referral_code', { length: 30 }),
    status: varchar('status', { length: 30 }).notNull().default('active'),
    expiresAt: timestamp('expires_at', { withTimezone: true }),
    convertedAt: timestamp('converted_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    sessionTokenUk: uniqueIndex('cart_sessions_token_uk').on(t.sessionToken),
    tenantIdx: index('cart_sessions_tenant_idx').on(t.tenantId),
    locationIdx: index('cart_sessions_location_idx').on(t.locationId),
    customerIdx: index('cart_sessions_customer_idx').on(t.customerId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 8 — ORDERS
   Discounts → Delivery Zones → Orders → Items → Status Log
═══════════════════════════════════════════════════════════════════ */

export const discounts = pgTable(
  'discounts',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id').references(() => locations.id),
    name: varchar('name', { length: 255 }).notNull(),
    code: varchar('code', { length: 100 }).notNull(),
    discountType: discountTypeEnum('discount_type').notNull(),
    value: decimal('value', { precision: 12, scale: 2 }).notNull(),
    maxDiscountCap: decimal('max_discount_cap', { precision: 12, scale: 2 }),
    minOrderAmount: decimal('min_order_amount', { precision: 12, scale: 2 }),
    applicableOrderTypes: orderTypeEnum('applicable_order_types').array(),
    applicableChannels: orderSourceEnum('applicable_channels').array(),
    maxTotalUses: integer('max_total_uses'),
    maxUsesPerCustomer: integer('max_uses_per_customer'),
    /**
     * SCALABILITY NOTE: Do NOT read currentUses directly for validation.
     * Use discount_redemptions COUNT query instead.
     * currentUses is a stale display-only cache updated by a background job.
     */
    currentUsesCache: integer('current_uses_cache').default(0).notNull(),
    isFirstOrderOnly: boolean('is_first_order_only').default(false).notNull(),
    isActive: boolean('is_active').default(true).notNull(),
    validFrom: date('valid_from'),
    validTo: date('valid_to'),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantCodeUk: uniqueIndex('discounts_tenant_code_uk').on(
      t.tenantId,
      t.code,
    ),
    tenantIdx: index('discounts_tenant_idx').on(t.tenantId),
    locationIdx: index('discounts_location_idx').on(t.locationId),
  }),
);

export const deliveryZones = pgTable(
  'delivery_zones',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    name: varchar('name', { length: 255 }).notNull(),
    polygonCoordinates: jsonb('polygon_coordinates'), // GeoJSON polygon
    minOrderAmount: decimal('min_order_amount', { precision: 12, scale: 2 }),
    deliveryFee: decimal('delivery_fee', { precision: 12, scale: 2 }).notNull(),
    freeDeliveryAbove: decimal('free_delivery_above', {
      precision: 12,
      scale: 2,
    }),
    estimatedMinMinutes: integer('estimated_min_minutes'),
    estimatedMaxMinutes: integer('estimated_max_minutes'),
    isActive: boolean('is_active').default(true).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    locationIdx: index('delivery_zones_location_idx').on(t.locationId),
  }),
);

export const onlineOrders = pgTable(
  'online_orders',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    customerId: uuid('customer_id').references(() => customers.id),
    deliveryAddressId: uuid('delivery_address_id').references(
      () => customerAddresses.id,
    ),
    deliveryZoneId: uuid('delivery_zone_id').references(() => deliveryZones.id),
    discountId: uuid('discount_id').references(() => discounts.id),
    qrCodeId: uuid('qr_code_id').references(() => qrCodes.id),
    groupSessionId: uuid('group_session_id').references(
      () => groupOrderSessions.id,
    ),
    kioskTerminalId: uuid('kiosk_terminal_id').references(
      () => kioskTerminals.id,
    ),
    // Order identity
    orderNumber: varchar('order_number', { length: 120 }).notNull(),
    orderType: orderTypeEnum('order_type').notNull(),
    orderSource: orderSourceEnum('order_source').notNull(),
    tableNumber: varchar('table_number', { length: 50 }),
    aggregatorName: varchar('aggregator_name', { length: 50 }),
    aggregatorOrderId: varchar('aggregator_order_id', { length: 255 }),
    // Status
    status: orderStatusEnum('status').notNull().default('pending'),
    paymentStatus: paymentStatusEnum('payment_status')
      .notNull()
      .default('unpaid'),
    cancelledBy: uuid('cancelled_by'),
    cancelledByType: actorTypeEnum('cancelled_by_type'),
    cancellationReason: varchar('cancellation_reason', { length: 255 }),
    kitchenNotes: text('kitchen_notes'),
    // Financials
    subtotal: decimal('subtotal', { precision: 12, scale: 2 }).notNull(),
    discountAmount: decimal('discount_amount', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    deliveryFee: decimal('delivery_fee', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    taxAmount: decimal('tax_amount', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    tipAmount: decimal('tip_amount', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    serviceCharge: decimal('service_charge', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    walletAmountUsed: decimal('wallet_amount_used', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    loyaltyAmountUsed: decimal('loyalty_amount_used', {
      precision: 12,
      scale: 2,
    })
      .default('0')
      .notNull(),
    total: decimal('total', { precision: 12, scale: 2 }).notNull(),
    currency: varchar('currency', { length: 10 }).default('PKR').notNull(),
    // Tax compliance fields
    fbrPosCharge: decimal('fbr_pos_charge', { precision: 12, scale: 2 }),
    fbrPosChargeRate: decimal('fbr_pos_charge_rate', {
      precision: 8,
      scale: 4,
    }),
    fbrInvoiceNumber: varchar('fbr_invoice_number', { length: 120 }),
    srbTaxAmount: decimal('srb_tax_amount', { precision: 12, scale: 2 }),
    // Notes
    customerNotes: text('customer_notes'),
    internalNotes: text('internal_notes'),
    // Timing
    estimatedPrepMinutes: integer('estimated_prep_minutes'),
    scheduledFor: timestamp('scheduled_for', { withTimezone: true }),
    isPreOrder: boolean('is_pre_order').default(false).notNull(),
    confirmedAt: timestamp('confirmed_at', { withTimezone: true }),
    preparingAt: timestamp('preparing_at', { withTimezone: true }),
    readyAt: timestamp('ready_at', { withTimezone: true }),
    outForDeliveryAt: timestamp('out_for_delivery_at', { withTimezone: true }),
    deliveredAt: timestamp('delivered_at', { withTimezone: true }),
    dailyTicket: integer('daily_ticket'), // ← ADD THIS LINE
    cancelledAt: timestamp('cancelled_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    orderNumberUk: uniqueIndex('online_orders_number_uk').on(t.orderNumber),
    tenantIdx: index('online_orders_tenant_idx').on(t.tenantId),
    locationIdx: index('online_orders_location_idx').on(t.locationId),
    customerIdx: index('online_orders_customer_idx').on(t.customerId),
    deliveryZoneIdx: index('online_orders_delivery_zone_idx').on(
      t.deliveryZoneId,
    ),
    discountIdx: index('online_orders_discount_idx').on(t.discountId),
    // Primary dashboard query — tenant + location + status + created_at
    statusCreatedIdx: index('online_orders_status_created_idx').on(
      t.tenantId,
      t.locationId,
      t.status,
      t.createdAt,
    ),
    scheduledIdx: index('online_orders_scheduled_idx').on(
      t.tenantId,
      t.scheduledFor,
    ),
  }),
);
export const dailyOrderCounters = pgTable(
  'daily_order_counters',
  {
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    date: date('date').notNull(),
    lastSeq: integer('last_seq').notNull().default(0),
  },
  (t) => ({
    pk: primaryKey({ columns: [t.tenantId, t.locationId, t.date] }),
    tenantIdx: index('daily_counter_tenant_idx').on(t.tenantId),
  }),
);
export const onlineOrderItems = pgTable(
  'online_order_items',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    orderId: uuid('order_id')
      .notNull()
      .references(() => onlineOrders.id, { onDelete: 'cascade' }),
    menuItemId: uuid('menu_item_id').references(() => menuItems.id),
    // Price/name snapshots — immutable after order placed
    itemNameSnapshot: varchar('item_name_snapshot', { length: 255 }).notNull(),
    itemSkuSnapshot: varchar('item_sku_snapshot', { length: 120 }),
    unitPriceSnapshot: decimal('unit_price_snapshot', {
      precision: 12,
      scale: 2,
    }).notNull(),
    discountPriceSnapshot: decimal('discount_price_snapshot', {
      precision: 12,
      scale: 2,
    }),
    quantity: integer('quantity').notNull(),
    modifierTotal: decimal('modifier_total', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    lineDiscount: decimal('line_discount', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    lineTotal: decimal('line_total', { precision: 12, scale: 2 }).notNull(),
    specialInstructions: text('special_instructions'),
    status: orderItemStatusEnum('status').notNull().default('pending'),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    orderIdx: index('order_items_order_idx').on(t.orderId),
    menuItemIdx: index('order_items_menu_item_idx').on(t.menuItemId),
  }),
);

export const onlineOrderItemModifiers = pgTable(
  'online_order_item_modifiers',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    orderItemId: uuid('order_item_id')
      .notNull()
      .references(() => onlineOrderItems.id, { onDelete: 'cascade' }),
    modifierId: uuid('modifier_id').references(() => modifiers.id),
    modifierNameSnapshot: varchar('modifier_name_snapshot', {
      length: 255,
    }).notNull(),
    groupNameSnapshot: varchar('group_name_snapshot', { length: 255 }),
    priceDeltaSnapshot: decimal('price_delta_snapshot', {
      precision: 12,
      scale: 2,
    }).notNull(),
    quantity: integer('quantity').default(1).notNull(),
  },
  (t) => ({
    orderItemIdx: index('order_item_modifiers_item_idx').on(t.orderItemId),
    modifierIdx: index('order_item_modifiers_modifier_idx').on(t.modifierId),
  }),
);

export const onlineOrderStatusLogs = pgTable(
  'online_order_status_logs',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    orderId: uuid('order_id')
      .notNull()
      .references(() => onlineOrders.id),
    changedBy: uuid('changed_by'),
    actorType: actorTypeEnum('actor_type'),
    fromStatus: orderStatusEnum('from_status'),
    toStatus: orderStatusEnum('to_status').notNull(),
    note: text('note'),
    ipAddress: varchar('ip_address', { length: 45 }),
    changedAt: timestamp('changed_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    orderIdx: index('order_status_logs_order_idx').on(t.orderId),
  }),
);

export const upsellImpressions = pgTable(
  'upsell_impressions',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    orderId: uuid('order_id').references(() => onlineOrders.id),
    customerId: uuid('customer_id').references(() => customers.id),
    menuItemId: uuid('menu_item_id').references(() => menuItems.id),
    upsellType: varchar('upsell_type', { length: 50 }),
    wasAdded: boolean('was_added').default(false).notNull(),
    itemPrice: decimal('item_price', { precision: 12, scale: 2 }),
    shownAt: timestamp('shown_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    addedAt: timestamp('added_at', { withTimezone: true }),
  },
  (t) => ({
    tenantIdx: index('upsell_tenant_idx').on(t.tenantId),
    orderIdx: index('upsell_order_idx').on(t.orderId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 9 — DELIVERY
   Drivers, Deliveries, GPS Tracking
═══════════════════════════════════════════════════════════════════ */

export const drivers = pgTable(
  'drivers',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id').references(() => locations.id),
    fullName: varchar('full_name', { length: 255 }).notNull(),
    phone: varchar('phone', { length: 50 }).notNull(),
    cnic: varchar('cnic', { length: 20 }),
    vehicleType: vehicleTypeEnum('vehicle_type'),
    vehicleNumber: varchar('vehicle_number', { length: 100 }),
    vehicleColor: varchar('vehicle_color', { length: 50 }),
    status: driverStatusEnum('status').notNull().default('offline'),
    currentLatitude: decimal('current_latitude', { precision: 10, scale: 7 }),
    currentLongitude: decimal('current_longitude', { precision: 10, scale: 7 }),
    fcmToken: text('fcm_token'),
    isActive: boolean('is_active').default(true).notNull(),
    totalDeliveries: integer('total_deliveries').default(0).notNull(),
    avgRating: decimal('avg_rating', { precision: 4, scale: 2 }),
    lastLocationAt: timestamp('last_location_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantPhoneUk: uniqueIndex('drivers_tenant_phone_uk').on(
      t.tenantId,
      t.phone,
    ),
    tenantIdx: index('drivers_tenant_idx').on(t.tenantId),
    locationIdx: index('drivers_location_idx').on(t.locationId),
    statusIdx: index('drivers_status_idx').on(t.tenantId, t.status),
  }),
);

export const deliveries = pgTable(
  'deliveries',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    orderId: uuid('order_id')
      .notNull()
      .references(() => onlineOrders.id),
    driverId: uuid('driver_id').references(() => drivers.id),
    locationId: uuid('location_id').references(() => locations.id),
    deliveryZoneId: uuid('delivery_zone_id').references(() => deliveryZones.id),
    status: deliveryStatusEnum('status').notNull().default('pending'),
    pickupLatitude: decimal('pickup_latitude', { precision: 10, scale: 7 }),
    pickupLongitude: decimal('pickup_longitude', { precision: 10, scale: 7 }),
    dropoffLatitude: decimal('dropoff_latitude', { precision: 10, scale: 7 }),
    dropoffLongitude: decimal('dropoff_longitude', { precision: 10, scale: 7 }),
    dropoffAddressSnapshot: text('dropoff_address_snapshot'),
    estimatedMinutes: integer('estimated_minutes'),
    actualMinutes: integer('actual_minutes'),
    distanceKm: decimal('distance_km', { precision: 8, scale: 2 }),
    trackingToken: varchar('tracking_token', { length: 255 }).notNull(),
    deliveryNotes: text('delivery_notes'),
    failureReason: text('failure_reason'),
    proofOfDeliveryUrl: text('proof_of_delivery_url'),
    assignedAt: timestamp('assigned_at', { withTimezone: true }),
    pickedUpAt: timestamp('picked_up_at', { withTimezone: true }),
    deliveredAt: timestamp('delivered_at', { withTimezone: true }),
    failedAt: timestamp('failed_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    trackingTokenUk: uniqueIndex('deliveries_tracking_token_uk').on(
      t.trackingToken,
    ),
    orderIdx: index('deliveries_order_idx').on(t.orderId),
    driverIdx: index('deliveries_driver_idx').on(t.driverId),
    locationIdx: index('deliveries_location_idx').on(t.locationId),
    statusIdx: index('deliveries_status_idx').on(t.status),
  }),
);

/**
 * High-frequency write table — partition by delivery_id or use TimescaleDB.
 * Retain last 30 days only; archive to cold storage.
 */
export const deliveryTrackingHistory = pgTable(
  'delivery_tracking_history',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    deliveryId: uuid('delivery_id')
      .notNull()
      .references(() => deliveries.id),
    latitude: decimal('latitude', { precision: 10, scale: 7 }).notNull(),
    longitude: decimal('longitude', { precision: 10, scale: 7 }).notNull(),
    speedKmh: integer('speed_kmh'),
    heading: integer('heading'),
    recordedAt: timestamp('recorded_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    deliveryIdx: index('tracking_history_delivery_idx').on(t.deliveryId),
    recordedAtIdx: index('tracking_history_recorded_at_idx').on(
      t.deliveryId,
      t.recordedAt,
    ),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 10 — PAYMENTS & REFUNDS
═══════════════════════════════════════════════════════════════════ */

export const payments = pgTable(
  'payments',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    orderId: uuid('order_id').references(() => onlineOrders.id),
    customerId: uuid('customer_id').references(() => customers.id),
    locationId: uuid('location_id').references(() => locations.id),
    paymentMethod: paymentMethodEnum('payment_method').notNull(),
    paymentGateway: paymentGatewayEnum('payment_gateway').notNull(),
    gatewayPaymentId: varchar('gateway_payment_id', { length: 255 }),
    amount: decimal('amount', { precision: 12, scale: 2 }).notNull(),
    tipAmount: decimal('tip_amount', { precision: 12, scale: 2 }).default('0'),
    refundedAmount: decimal('refunded_amount', { precision: 12, scale: 2 })
      .default('0')
      .notNull(),
    currency: varchar('currency', { length: 10 }).default('PKR').notNull(),
    cardLast4: varchar('card_last4', { length: 4 }),
    cardBrand: varchar('card_brand', { length: 30 }),
    mobileWalletNumber: varchar('mobile_wallet_number', { length: 50 }),
    status: varchar('status', { length: 30 }).notNull().default('pending'),
    gatewayResponse: jsonb('gateway_response'),
    authorizedAt: timestamp('authorized_at', { withTimezone: true }),
    capturedAt: timestamp('captured_at', { withTimezone: true }),
    failedAt: timestamp('failed_at', { withTimezone: true }),
    refundedAt: timestamp('refunded_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    gatewayPaymentIdUk: uniqueIndex('payments_gateway_payment_id_uk').on(
      t.gatewayPaymentId,
    ),
    tenantIdx: index('payments_tenant_idx').on(t.tenantId),
    orderIdx: index('payments_order_idx').on(t.orderId),
    customerIdx: index('payments_customer_idx').on(t.customerId),
    locationIdx: index('payments_location_idx').on(t.locationId),
  }),
);

export const refunds = pgTable(
  'refunds',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    paymentId: uuid('payment_id')
      .notNull()
      .references(() => payments.id),
    orderId: uuid('order_id').references(() => onlineOrders.id),
    initiatedBy: uuid('initiated_by'),
    initiatedByType: actorTypeEnum('initiated_by_type'),
    amount: decimal('amount', { precision: 12, scale: 2 }).notNull(),
    reason: varchar('reason', { length: 100 }),
    status: refundStatusEnum('status').notNull().default('pending'),
    refundMethod: refundMethodEnum('refund_method'),
    gatewayRefundId: varchar('gateway_refund_id', { length: 255 }),
    notes: text('notes'),
    processedAt: timestamp('processed_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    paymentIdx: index('refunds_payment_idx').on(t.paymentId),
    orderIdx: index('refunds_order_idx').on(t.orderId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 11 — PROMOTIONS
   Discount redemptions log
═══════════════════════════════════════════════════════════════════ */

export const discountRedemptions = pgTable(
  'discount_redemptions',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    discountId: uuid('discount_id')
      .notNull()
      .references(() => discounts.id),
    orderId: uuid('order_id')
      .notNull()
      .references(() => onlineOrders.id),
    customerId: uuid('customer_id').references(() => customers.id),
    locationId: uuid('location_id').references(() => locations.id),
    amountSaved: decimal('amount_saved', { precision: 12, scale: 2 }).notNull(),
    redeemedAt: timestamp('redeemed_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    discountIdx: index('discount_redemptions_discount_idx').on(t.discountId),
    orderIdx: index('discount_redemptions_order_idx').on(t.orderId),
    customerIdx: index('discount_redemptions_customer_idx').on(t.customerId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 12 — AGGREGATOR INTEGRATIONS
   Zomato, Foodpanda, Careem Eats, Bykea Food, etc.
═══════════════════════════════════════════════════════════════════ */

export const aggregatorIntegrations = pgTable(
  'aggregator_integrations',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id').references(() => locations.id),
    aggregatorName: varchar('aggregator_name', { length: 50 }).notNull(),
    // Encrypt at rest in production — never store plaintext
    apiKeyEncrypted: text('api_key_encrypted'),
    storeId: varchar('store_id', { length: 255 }),
    externalBranchId: varchar('external_branch_id', { length: 255 }),
    menuSyncStatus: menuSyncStatusEnum('menu_sync_status').default('pending'),
    autoAcceptOrders: boolean('auto_accept_orders').default(false).notNull(),
    isActive: boolean('is_active').default(true).notNull(),
    lastMenuSyncAt: timestamp('last_menu_sync_at', { withTimezone: true }),
    lastOrderAt: timestamp('last_order_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('agg_integrations_tenant_idx').on(t.tenantId),
    locationIdx: index('agg_integrations_location_idx').on(t.locationId),
    tenantAggUk: uniqueIndex('agg_integrations_tenant_agg_location_uk').on(
      t.tenantId,
      t.aggregatorName,
      t.locationId,
    ),
  }),
);

export const aggregatorItemMappings = pgTable(
  'aggregator_item_mappings',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    aggregatorIntegrationId: uuid('aggregator_integration_id')
      .notNull()
      .references(() => aggregatorIntegrations.id),
    menuItemId: uuid('menu_item_id')
      .notNull()
      .references(() => menuItems.id),
    aggregatorItemId: varchar('aggregator_item_id', { length: 255 }),
    aggregatorItemName: varchar('aggregator_item_name', { length: 255 }),
    aggregatorPrice: decimal('aggregator_price', { precision: 12, scale: 2 }),
    isSynced: boolean('is_synced').default(false).notNull(),
    isAvailableOnAggregator: boolean('is_available_on_aggregator')
      .default(true)
      .notNull(),
    lastSyncedAt: timestamp('last_synced_at', { withTimezone: true }),
  },
  (t) => ({
    integrationIdx: index('agg_item_mappings_integration_idx').on(
      t.aggregatorIntegrationId,
    ),
    menuItemIdx: index('agg_item_mappings_menu_item_idx').on(t.menuItemId),
    integrationItemUk: uniqueIndex('agg_item_mappings_integration_item_uk').on(
      t.aggregatorIntegrationId,
      t.menuItemId,
    ),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 13 — NOTIFICATIONS
   Templates, Log, Outbox (event-driven delivery)
═══════════════════════════════════════════════════════════════════ */

export const notificationTemplates = pgTable(
  'notification_templates',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    eventType: varchar('event_type', { length: 100 }).notNull(),
    channel: notificationChannelEnum('channel').notNull(),
    language: varchar('language', { length: 10 }).default('en').notNull(),
    subject: varchar('subject', { length: 255 }),
    bodyTemplate: text('body_template').notNull(),
    isActive: boolean('is_active').default(true).notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('notification_templates_tenant_idx').on(t.tenantId),
    tenantEventChannelLangUk: uniqueIndex('notification_templates_uk').on(
      t.tenantId,
      t.eventType,
      t.channel,
      t.language,
    ),
  }),
);

export const notifications = pgTable(
  'notifications',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    orderId: uuid('order_id').references(() => onlineOrders.id),
    customerId: uuid('customer_id').references(() => customers.id),
    locationId: uuid('location_id').references(() => locations.id),
    channel: notificationChannelEnum('channel').notNull(),
    eventType: varchar('event_type', { length: 100 }).notNull(),
    recipient: varchar('recipient', { length: 255 }).notNull(),
    content: text('content'),
    status: notificationStatusEnum('status').notNull().default('pending'),
    retryCount: integer('retry_count').default(0).notNull(),
    failureReason: text('failure_reason'),
    scheduledAt: timestamp('scheduled_at', { withTimezone: true }),
    sentAt: timestamp('sent_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('notifications_tenant_idx').on(t.tenantId),
    orderIdx: index('notifications_order_idx').on(t.orderId),
    customerIdx: index('notifications_customer_idx').on(t.customerId),
    statusIdx: index('notifications_status_idx').on(t.status, t.scheduledAt),
  }),
);

/**
 * Transactional outbox for reliable event publishing.
 * Worker polls this table and publishes to message queue (SQS/Kafka).
 * Use SKIP LOCKED for concurrent workers.
 */
export const outboxEvents = pgTable(
  'outbox_events',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id').notNull(),
    aggregateType: varchar('aggregate_type', { length: 50 }).notNull(), // 'order','customer','payment'
    aggregateId: uuid('aggregate_id').notNull(),
    eventType: varchar('event_type', { length: 100 }).notNull(), // 'order.confirmed','payment.captured'
    payload: jsonb('payload').notNull(),
    status: outboxStatusEnum('status').notNull().default('pending'),
    retryCount: integer('retry_count').default(0).notNull(),
    nextRetryAt: timestamp('next_retry_at', { withTimezone: true }),
    publishedAt: timestamp('published_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('outbox_events_tenant_idx').on(t.tenantId),
    statusIdx: index('outbox_events_status_idx').on(t.status, t.nextRetryAt),
    aggregateIdx: index('outbox_events_aggregate_idx').on(
      t.aggregateType,
      t.aggregateId,
    ),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 14 — RESERVATIONS
═══════════════════════════════════════════════════════════════════ */

export const reservations = pgTable(
  'reservations',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    customerId: uuid('customer_id').references(() => customers.id),
    reservationNumber: varchar('reservation_number', { length: 120 }).notNull(),
    customerName: varchar('customer_name', { length: 255 }),
    customerPhone: varchar('customer_phone', { length: 50 }),
    customerEmail: varchar('customer_email', { length: 255 }),
    partySize: integer('party_size').notNull(),
    reservationDate: date('reservation_date').notNull(),
    reservationTime: time('reservation_time').notNull(),
    durationMinutes: integer('duration_minutes').default(90),
    tablePreference: varchar('table_preference', { length: 50 }),
    status: reservationStatusEnum('status').notNull().default('pending'),
    specialRequests: text('special_requests'),
    occasion: varchar('occasion', { length: 50 }),
    source: varchar('source', { length: 30 }),
    confirmedAt: timestamp('confirmed_at', { withTimezone: true }),
    cancelledAt: timestamp('cancelled_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    reservationNumberUk: uniqueIndex('reservations_number_uk').on(
      t.reservationNumber,
    ),
    tenantIdx: index('reservations_tenant_idx').on(t.tenantId),
    locationIdx: index('reservations_location_idx').on(t.locationId),
    customerIdx: index('reservations_customer_idx').on(t.customerId),
    dateIdx: index('reservations_date_idx').on(t.locationId, t.reservationDate),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 15 — TAX COMPLIANCE
   Pakistan FBR / SRB + MENA expansion (UAE ZATCA, KSA)
═══════════════════════════════════════════════════════════════════ */

export const fbrInvoices = pgTable(
  'fbr_invoices',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id').references(() => locations.id),
    orderId: uuid('order_id').references(() => onlineOrders.id),
    fbrInvoiceNumber: varchar('fbr_invoice_number', { length: 120 }).notNull(),
    fbrPosId: varchar('fbr_pos_id', { length: 100 }),
    invoiceAmount: decimal('invoice_amount', { precision: 12, scale: 2 }),
    fbrPosCharge: decimal('fbr_pos_charge', { precision: 12, scale: 2 }),
    fbrPosChargeRate: decimal('fbr_pos_charge_rate', {
      precision: 8,
      scale: 4,
    }),
    paymentMode: paymentMethodEnum('payment_mode'),
    status: fbrStatusEnum('status').notNull().default('pending'),
    fbrResponseRaw: jsonb('fbr_response_raw'),
    transmittedAt: timestamp('transmitted_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    invoiceNumberUk: uniqueIndex('fbr_invoices_number_uk').on(
      t.fbrInvoiceNumber,
    ),
    tenantIdx: index('fbr_invoices_tenant_idx').on(t.tenantId),
    orderIdx: index('fbr_invoices_order_idx').on(t.orderId),
  }),
);

export const srbInvoices = pgTable(
  'srb_invoices',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id').references(() => locations.id),
    orderId: uuid('order_id').references(() => onlineOrders.id),
    srbInvoiceNumber: varchar('srb_invoice_number', { length: 120 }).notNull(),
    srbRegistrationNumber: varchar('srb_registration_number', { length: 100 }),
    invoiceAmount: decimal('invoice_amount', { precision: 12, scale: 2 }),
    srbTaxAmount: decimal('srb_tax_amount', { precision: 12, scale: 2 }),
    srbTaxRate: decimal('srb_tax_rate', { precision: 8, scale: 4 }),
    status: fbrStatusEnum('status').notNull().default('pending'),
    srbResponseRaw: jsonb('srb_response_raw'),
    transmittedAt: timestamp('transmitted_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    invoiceNumberUk: uniqueIndex('srb_invoices_number_uk').on(
      t.srbInvoiceNumber,
    ),
    tenantIdx: index('srb_invoices_tenant_idx').on(t.tenantId),
    orderIdx: index('srb_invoices_order_idx').on(t.orderId),
  }),
);

/** Extensible tax record for MENA expansion (UAE, KSA, Egypt, etc.) */
export const taxInvoices = pgTable(
  'tax_invoices',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id').references(() => locations.id),
    orderId: uuid('order_id').references(() => onlineOrders.id),
    taxAuthority: varchar('tax_authority', { length: 50 }).notNull(), // 'zatca','ira','vra'
    countryCode: varchar('country_code', { length: 10 }).notNull(),
    invoiceNumber: varchar('invoice_number', { length: 120 }).notNull(),
    invoiceAmount: decimal('invoice_amount', { precision: 12, scale: 2 }),
    taxAmount: decimal('tax_amount', { precision: 12, scale: 2 }),
    taxRate: decimal('tax_rate', { precision: 8, scale: 4 }),
    qrCodeData: text('qr_code_data'), // ZATCA e-invoice QR
    status: fbrStatusEnum('status').notNull().default('pending'),
    rawResponse: jsonb('raw_response'),
    transmittedAt: timestamp('transmitted_at', { withTimezone: true }),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    invoiceNumberUk: uniqueIndex('tax_invoices_number_uk').on(
      t.tenantId,
      t.taxAuthority,
      t.invoiceNumber,
    ),
    tenantIdx: index('tax_invoices_tenant_idx').on(t.tenantId),
    orderIdx: index('tax_invoices_order_idx').on(t.orderId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 16 — AI & INTELLIGENCE
   Demand forecasting, upsell models, churn, benchmarks
═══════════════════════════════════════════════════════════════════ */

/**
 * AI-generated item pair suggestions per tenant/location.
 * Recomputed nightly by the ML pipeline.
 * Used to power "Customers also ordered…" and smart upsell triggers.
 */
export const aiItemAffinities = pgTable(
  'ai_item_affinities',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id').references(() => locations.id),
    sourceItemId: uuid('source_item_id')
      .notNull()
      .references(() => menuItems.id),
    targetItemId: uuid('target_item_id')
      .notNull()
      .references(() => menuItems.id),
    affinityScore: decimal('affinity_score', {
      precision: 8,
      scale: 6,
    }).notNull(), // 0–1
    coOccurrenceCount: integer('co_occurrence_count').notNull(),
    liftScore: decimal('lift_score', { precision: 8, scale: 4 }), // market basket lift
    computedAt: timestamp('computed_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('ai_affinities_tenant_idx').on(t.tenantId),
    sourceItemIdx: index('ai_affinities_source_idx').on(t.sourceItemId),
    pairUk: uniqueIndex('ai_affinities_pair_uk').on(
      t.tenantId,
      t.locationId,
      t.sourceItemId,
      t.targetItemId,
    ),
  }),
);

/**
 * Hourly demand forecast per location.
 * Drives prep time estimates and staffing recommendations.
 */
export const aiDemandForecasts = pgTable(
  'ai_demand_forecasts',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    forecastDate: date('forecast_date').notNull(),
    forecastHour: smallint('forecast_hour').notNull(), // 0–23
    predictedOrders: integer('predicted_orders'),
    predictedRevenue: decimal('predicted_revenue', { precision: 12, scale: 2 }),
    confidenceScore: decimal('confidence_score', { precision: 5, scale: 4 }),
    modelVersion: varchar('model_version', { length: 50 }),
    computedAt: timestamp('computed_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    locationDateUk: uniqueIndex('ai_forecasts_location_date_hour_uk').on(
      t.locationId,
      t.forecastDate,
      t.forecastHour,
    ),
    tenantIdx: index('ai_forecasts_tenant_idx').on(t.tenantId),
  }),
);

/**
 * Customer churn risk scores — updated weekly.
 * score > 0.7 = high risk; trigger automated win-back campaign.
 */
export const aiChurnScores = pgTable(
  'ai_churn_scores',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    customerId: uuid('customer_id')
      .notNull()
      .references(() => customers.id),
    churnScore: decimal('churn_score', { precision: 5, scale: 4 }).notNull(), // 0–1
    daysSinceLastOrder: integer('days_since_last_order'),
    avgOrderFrequencyDays: decimal('avg_order_frequency_days', {
      precision: 8,
      scale: 2,
    }),
    recommendedAction: varchar('recommended_action', { length: 100 }),
    winBackOfferId: uuid('win_back_offer_id').references(() => discounts.id),
    computedAt: timestamp('computed_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantCustomerUk: uniqueIndex('ai_churn_tenant_customer_uk').on(
      t.tenantId,
      t.customerId,
    ),
    tenantIdx: index('ai_churn_tenant_idx').on(t.tenantId),
    scoreIdx: index('ai_churn_score_idx').on(t.tenantId, t.churnScore),
  }),
);

/**
 * Anonymised benchmark data — aggregated per cuisine type + city.
 * Used to power "How you compare to similar restaurants" feature.
 * No PII — all aggregates with minimum cohort size of 5 tenants.
 */
export const tenantBenchmarks = pgTable(
  'tenant_benchmarks',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    cuisineType: varchar('cuisine_type', { length: 100 }),
    city: varchar('city', { length: 150 }),
    countryCode: varchar('country_code', { length: 10 })
      .default('PK')
      .notNull(),
    periodMonth: varchar('period_month', { length: 7 }).notNull(), // 'YYYY-MM'
    cohortSize: integer('cohort_size').notNull(), // must be >= 5
    p25AvgOrderValue: decimal('p25_avg_order_value', {
      precision: 12,
      scale: 2,
    }),
    p50AvgOrderValue: decimal('p50_avg_order_value', {
      precision: 12,
      scale: 2,
    }),
    p75AvgOrderValue: decimal('p75_avg_order_value', {
      precision: 12,
      scale: 2,
    }),
    p50RepeatOrderRate: decimal('p50_repeat_order_rate', {
      precision: 5,
      scale: 4,
    }),
    p50AvgDeliveryMinutes: decimal('p50_avg_delivery_minutes', {
      precision: 8,
      scale: 2,
    }),
    p50CancellationRate: decimal('p50_cancellation_rate', {
      precision: 5,
      scale: 4,
    }),
    computedAt: timestamp('computed_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    periodCuisineUk: uniqueIndex('benchmarks_period_cuisine_city_uk').on(
      t.periodMonth,
      t.cuisineType,
      t.city,
      t.countryCode,
    ),
  }),
);

/**
 * Per-tenant feature usage — populated nightly.
 * Powers automated upsell nudges and churn risk for SaaS layer.
 */
export const tenantFeatureUsage = pgTable(
  'tenant_feature_usage',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    periodMonth: varchar('period_month', { length: 7 }).notNull(),
    totalOrders: integer('total_orders').default(0).notNull(),
    onlineOrders: integer('online_orders').default(0).notNull(),
    qrOrders: integer('qr_orders').default(0).notNull(),
    whatsappOrders: integer('whatsapp_orders').default(0).notNull(),
    kioskOrders: integer('kiosk_orders').default(0).notNull(),
    loyaltyRedemptions: integer('loyalty_redemptions').default(0).notNull(),
    walletTopups: integer('wallet_topups').default(0).notNull(),
    aggregatorOrders: integer('aggregator_orders').default(0).notNull(),
    activeDrivers: integer('active_drivers').default(0).notNull(),
    uniqueCustomers: integer('unique_customers').default(0).notNull(),
    computedAt: timestamp('computed_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantPeriodUk: uniqueIndex('tenant_feature_usage_tenant_period_uk').on(
      t.tenantId,
      t.periodMonth,
    ),
    tenantIdx: index('tenant_feature_usage_tenant_idx').on(t.tenantId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 17 — INVENTORY & PROCUREMENT
   Ingredients, Suppliers, Stock, Purchase Orders
═══════════════════════════════════════════════════════════════════ */

export const suppliers = pgTable(
  'suppliers',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    name: varchar('name', { length: 255 }).notNull(),
    contactName: varchar('contact_name', { length: 255 }),
    phone: varchar('phone', { length: 50 }),
    email: varchar('email', { length: 255 }),
    address: text('address'),
    status: supplierStatusEnum('status').notNull().default('active'),
    notes: text('notes'),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('suppliers_tenant_idx').on(t.tenantId),
  }),
);

export const ingredients = pgTable(
  'ingredients',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    name: varchar('name', { length: 255 }).notNull(),
    sku: varchar('sku', { length: 120 }),
    uom: varchar('uom', { length: 50 }).notNull(), // 'kg','litre','piece','gram'
    costPerUnit: decimal('cost_per_unit', { precision: 12, scale: 4 }),
    preferredSupplierId: uuid('preferred_supplier_id').references(
      () => suppliers.id,
    ),
    reorderThreshold: decimal('reorder_threshold', { precision: 12, scale: 4 }),
    isActive: boolean('is_active').default(true).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('ingredients_tenant_idx').on(t.tenantId),
    tenantSkuUk: uniqueIndex('ingredients_tenant_sku_uk').on(t.tenantId, t.sku),
  }),
);

/** Maps menu items to their ingredient bill-of-materials */
export const menuItemIngredients = pgTable(
  'menu_item_ingredients',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    menuItemId: uuid('menu_item_id')
      .notNull()
      .references(() => menuItems.id),
    ingredientId: uuid('ingredient_id')
      .notNull()
      .references(() => ingredients.id),
    quantityPerUnit: decimal('quantity_per_unit', {
      precision: 12,
      scale: 4,
    }).notNull(),
    uom: varchar('uom', { length: 50 }).notNull(),
  },
  (t) => ({
    itemIngredientUk: uniqueIndex('menu_item_ingredients_uk').on(
      t.menuItemId,
      t.ingredientId,
    ),
    menuItemIdx: index('menu_item_ingredients_item_idx').on(t.menuItemId),
    ingredientIdx: index('menu_item_ingredients_ingredient_idx').on(
      t.ingredientId,
    ),
  }),
);

/** Current stock levels per ingredient per location */
export const inventoryStock = pgTable(
  'inventory_stock',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    ingredientId: uuid('ingredient_id')
      .notNull()
      .references(() => ingredients.id),
    // Current balance — derived from inventory_transactions ledger
    // This is a cached snapshot updated by the inventory service
    currentStock: decimal('current_stock', { precision: 12, scale: 4 })
      .notNull()
      .default('0'),
    lastCountedAt: timestamp('last_counted_at', { withTimezone: true }),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    locationIngredientUk: uniqueIndex(
      'inventory_stock_location_ingredient_uk',
    ).on(t.locationId, t.ingredientId),
    tenantIdx: index('inventory_stock_tenant_idx').on(t.tenantId),
    locationIdx: index('inventory_stock_location_idx').on(t.locationId),
  }),
);

/** Append-only inventory ledger */
export const inventoryTransactions = pgTable(
  'inventory_transactions',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    ingredientId: uuid('ingredient_id')
      .notNull()
      .references(() => ingredients.id),
    type: inventoryTransactionTypeEnum('type').notNull(),
    quantity: decimal('quantity', { precision: 12, scale: 4 }).notNull(),
    unitCost: decimal('unit_cost', { precision: 12, scale: 4 }),
    referenceType: varchar('reference_type', { length: 50 }),
    referenceId: uuid('reference_id'),
    notes: text('notes'),
    createdBy: uuid('created_by').references(() => users.id),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('inv_tx_tenant_idx').on(t.tenantId),
    locationIdx: index('inv_tx_location_idx').on(t.locationId),
    ingredientIdx: index('inv_tx_ingredient_idx').on(t.ingredientId),
  }),
);

export const purchaseOrders = pgTable(
  'purchase_orders',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    locationId: uuid('location_id')
      .notNull()
      .references(() => locations.id),
    supplierId: uuid('supplier_id')
      .notNull()
      .references(() => suppliers.id),
    poNumber: varchar('po_number', { length: 120 }).notNull(),
    status: varchar('status', { length: 30 }).notNull().default('draft'), // draft,sent,received,partial
    totalAmount: decimal('total_amount', { precision: 12, scale: 2 }),
    notes: text('notes'),
    expectedAt: date('expected_at'),
    receivedAt: timestamp('received_at', { withTimezone: true }),
    createdBy: uuid('created_by').references(() => users.id),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    poNumberUk: uniqueIndex('purchase_orders_number_uk').on(
      t.tenantId,
      t.poNumber,
    ),
    tenantIdx: index('purchase_orders_tenant_idx').on(t.tenantId),
    supplierIdx: index('purchase_orders_supplier_idx').on(t.supplierId),
  }),
);

export const purchaseOrderItems = pgTable(
  'purchase_order_items',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    purchaseOrderId: uuid('purchase_order_id')
      .notNull()
      .references(() => purchaseOrders.id, { onDelete: 'cascade' }),
    ingredientId: uuid('ingredient_id')
      .notNull()
      .references(() => ingredients.id),
    orderedQuantity: decimal('ordered_quantity', {
      precision: 12,
      scale: 4,
    }).notNull(),
    receivedQuantity: decimal('received_quantity', { precision: 12, scale: 4 })
      .default('0')
      .notNull(),
    unitCost: decimal('unit_cost', { precision: 12, scale: 4 }),
    lineTotal: decimal('line_total', { precision: 12, scale: 2 }),
  },
  (t) => ({
    poIdx: index('po_items_po_idx').on(t.purchaseOrderId),
    ingredientIdx: index('po_items_ingredient_idx').on(t.ingredientId),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   LAYER 18 — RATINGS, AUDIT & COMPLIANCE
═══════════════════════════════════════════════════════════════════ */

export const orderRatings = pgTable(
  'order_ratings',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    orderId: uuid('order_id')
      .notNull()
      .references(() => onlineOrders.id),
    customerId: uuid('customer_id').references(() => customers.id),
    locationId: uuid('location_id').references(() => locations.id),
    driverId: uuid('driver_id').references(() => drivers.id),
    foodRating: integer('food_rating'),
    deliveryRating: integer('delivery_rating'),
    packagingRating: integer('packaging_rating'),
    appExperienceRating: integer('app_experience_rating'),
    overallRating: integer('overall_rating'),
    reviewText: text('review_text'),
    sentiment: sentimentEnum('sentiment'),
    isPublished: boolean('is_published').default(false).notNull(),
    flaggedForReview: boolean('flagged_for_review').default(false).notNull(),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    orderUk: uniqueIndex('order_ratings_order_uk').on(t.orderId),
    customerIdx: index('order_ratings_customer_idx').on(t.customerId),
    locationIdx: index('order_ratings_location_idx').on(t.locationId),
  }),
);

/**
 * Audit logs — partitioned monthly by created_at in production.
 * Add: PARTITION BY RANGE (created_at) with monthly child tables.
 */
export const auditLogs = pgTable(
  'audit_logs',
  {
    id: uuid('id').defaultRandom().primaryKey(),
    tenantId: uuid('tenant_id')
      .notNull()
      .references(() => tenants.id),
    userId: uuid('user_id').references(() => users.id),
    locationId: uuid('location_id').references(() => locations.id),
    entityType: varchar('entity_type', { length: 50 }).notNull(),
    entityId: uuid('entity_id'),
    action: auditActionEnum('action').notNull(),
    beforeState: jsonb('before_state'),
    afterState: jsonb('after_state'),
    ipAddress: varchar('ip_address', { length: 45 }),
    userAgent: text('user_agent'),
    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (t) => ({
    tenantIdx: index('audit_logs_tenant_idx').on(t.tenantId),
    userIdx: index('audit_logs_user_idx').on(t.userId),
    entityIdx: index('audit_logs_entity_idx').on(t.entityType, t.entityId),
    tenantCreatedAtIdx: index('audit_logs_tenant_created_at_idx').on(
      t.tenantId,
      t.createdAt,
    ),
  }),
);

/* ═══════════════════════════════════════════════════════════════════
   DRIZZLE RELATIONS
═══════════════════════════════════════════════════════════════════ */

export const plansRelations = relations(plans, ({ many }) => ({
  tenants: many(tenants),
  subscriptions: many(subscriptions),
}));

export const tenantsRelations = relations(tenants, ({ one, many }) => ({
  plan: one(plans, { fields: [tenants.planId], references: [plans.id] }),
  subscriptions: many(subscriptions),
  brands: many(brands),
  users: many(users),
  locations: many(locations),
}));

export const subscriptionsRelations = relations(
  subscriptions,
  ({ one, many }) => ({
    tenant: one(tenants, {
      fields: [subscriptions.tenantId],
      references: [tenants.id],
    }),
    plan: one(plans, {
      fields: [subscriptions.planId],
      references: [plans.id],
    }),
    subscriptionInvoices: many(subscriptionInvoices),
  }),
);

export const subscriptionInvoicesRelations = relations(
  subscriptionInvoices,
  ({ one }) => ({
    subscription: one(subscriptions, {
      fields: [subscriptionInvoices.subscriptionId],
      references: [subscriptions.id],
    }),
    tenant: one(tenants, {
      fields: [subscriptionInvoices.tenantId],
      references: [tenants.id],
    }),
  }),
);

export const usersRelations = relations(users, ({ one, many }) => ({
  tenant: one(tenants, { fields: [users.tenantId], references: [tenants.id] }),
  userLocationAccess: many(userLocationAccess),
}));

export const userLocationAccessRelations = relations(
  userLocationAccess,
  ({ one }) => ({
    user: one(users, {
      fields: [userLocationAccess.userId],
      references: [users.id],
    }),
    role: one(roles, {
      fields: [userLocationAccess.roleId],
      references: [roles.id],
    }),
    location: one(locations, {
      fields: [userLocationAccess.locationId],
      references: [locations.id],
    }),
  }),
);

export const brandsRelations = relations(brands, ({ one, many }) => ({
  tenant: one(tenants, { fields: [brands.tenantId], references: [tenants.id] }),
  locations: many(locations),
  menus: many(menus),
}));

export const locationsRelations = relations(locations, ({ one, many }) => ({
  tenant: one(tenants, {
    fields: [locations.tenantId],
    references: [tenants.id],
  }),
  brand: one(brands, { fields: [locations.brandId], references: [brands.id] }),
  settings: many(locationSettings),
  hours: many(locationHours),
}));

export const menuItemsRelations = relations(menuItems, ({ one, many }) => ({
  tenant: one(tenants, {
    fields: [menuItems.tenantId],
    references: [tenants.id],
  }),
  category: one(menuCategories, {
    fields: [menuItems.categoryId],
    references: [menuCategories.id],
  }),
  taxClass: one(taxClasses, {
    fields: [menuItems.taxClassId],
    references: [taxClasses.id],
  }),
  modifierGroups: many(menuItemModifierGroups),
  locationOverrides: many(menuItemLocationOverrides),
}));

export const customersRelations = relations(customers, ({ one, many }) => ({
  tenant: one(tenants, {
    fields: [customers.tenantId],
    references: [tenants.id],
  }),
  addresses: many(customerAddresses),
  orders: many(onlineOrders),
}));

export const onlineOrdersRelations = relations(
  onlineOrders,
  ({ one, many }) => ({
    tenant: one(tenants, {
      fields: [onlineOrders.tenantId],
      references: [tenants.id],
    }),
    location: one(locations, {
      fields: [onlineOrders.locationId],
      references: [locations.id],
    }),
    customer: one(customers, {
      fields: [onlineOrders.customerId],
      references: [customers.id],
    }),
    items: many(onlineOrderItems),
    statusLogs: many(onlineOrderStatusLogs),
    delivery: many(deliveries),
    payments: many(payments),
    rating: many(orderRatings),
  }),
);

export const onlineOrderItemsRelations = relations(
  onlineOrderItems,
  ({ one, many }) => ({
    order: one(onlineOrders, {
      fields: [onlineOrderItems.orderId],
      references: [onlineOrders.id],
    }),
    menuItem: one(menuItems, {
      fields: [onlineOrderItems.menuItemId],
      references: [menuItems.id],
    }),
    modifiers: many(onlineOrderItemModifiers),
  }),
);
export const onlineOrderItemModifiersRelations = relations(
  onlineOrderItemModifiers,
  ({ one }) => ({
    orderItem: one(onlineOrderItems, {
      fields: [onlineOrderItemModifiers.orderItemId],
      references: [onlineOrderItems.id],
    }),
  }),
);
export const paymentsRelations = relations(payments, ({ one }) => ({
  order: one(onlineOrders, {
    fields: [payments.orderId],
    references: [onlineOrders.id],
  }),
}));
export const onlineOrderStatusLogsRelations = relations(
  onlineOrderStatusLogs,
  ({ one }) => ({
    order: one(onlineOrders, {
      fields: [onlineOrderStatusLogs.orderId],
      references: [onlineOrders.id],
    }),
  }),
);
export const orderRatingsRelations = relations(orderRatings, ({ one }) => ({
  order: one(onlineOrders, {
    fields: [orderRatings.orderId],
    references: [onlineOrders.id],
  }),
}));

export const deliveriesRelations = relations(deliveries, ({ one, many }) => ({
  order: one(onlineOrders, {
    fields: [deliveries.orderId],
    references: [onlineOrders.id],
  }),
  driver: one(drivers, {
    fields: [deliveries.driverId],
    references: [drivers.id],
  }),
  trackingHistory: many(deliveryTrackingHistory),
}));
