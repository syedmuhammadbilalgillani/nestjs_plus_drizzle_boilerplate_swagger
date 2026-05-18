CREATE TYPE "public"."actor_type" AS ENUM('user', 'customer', 'driver', 'system', 'aggregator');--> statement-breakpoint
CREATE TYPE "public"."ai_suggestion_type" AS ENUM('upsell_pair', 'reorder_prompt', 'win_back_offer', 'price_optimization', 'bundle_suggestion');--> statement-breakpoint
CREATE TYPE "public"."audit_action" AS ENUM('create', 'update', 'delete', 'login', 'logout', 'export', 'void', 'refund');--> statement-breakpoint
CREATE TYPE "public"."auth_provider" AS ENUM('email', 'google', 'apple', 'phone');--> statement-breakpoint
CREATE TYPE "public"."billing_cycle" AS ENUM('monthly', 'annual');--> statement-breakpoint
CREATE TYPE "public"."change_type" AS ENUM('upgrade', 'downgrade', 'trial_to_paid', 'cancel', 'reactivate');--> statement-breakpoint
CREATE TYPE "public"."delivery_status" AS ENUM('pending', 'assigned', 'accepted', 'picked_up', 'en_route', 'delivered', 'failed', 'returned');--> statement-breakpoint
CREATE TYPE "public"."discount_type" AS ENUM('percentage', 'fixed_amount', 'free_item', 'bogo');--> statement-breakpoint
CREATE TYPE "public"."driver_status" AS ENUM('offline', 'available', 'on_delivery', 'break');--> statement-breakpoint
CREATE TYPE "public"."fbr_status" AS ENUM('pending', 'transmitted', 'accepted', 'failed', 'not_applicable');--> statement-breakpoint
CREATE TYPE "public"."group_session_status" AS ENUM('open', 'locked', 'ordered', 'expired', 'cancelled');--> statement-breakpoint
CREATE TYPE "public"."inventory_transaction_type" AS ENUM('received', 'consumed', 'wasted', 'adjusted', 'transferred');--> statement-breakpoint
CREATE TYPE "public"."invoice_status" AS ENUM('draft', 'open', 'paid', 'void', 'uncollectible');--> statement-breakpoint
CREATE TYPE "public"."location_status" AS ENUM('active', 'inactive', 'coming_soon', 'permanently_closed');--> statement-breakpoint
CREATE TYPE "public"."location_type" AS ENUM('dine_in', 'cloud_kitchen', 'kiosk_only', 'pickup_only', 'delivery_only', 'hybrid', 'food_truck', 'drive_thru');--> statement-breakpoint
CREATE TYPE "public"."loyalty_transaction_type" AS ENUM('earn', 'redeem', 'expire', 'adjust', 'refund');--> statement-breakpoint
CREATE TYPE "public"."menu_status" AS ENUM('draft', 'published', 'archived');--> statement-breakpoint
CREATE TYPE "public"."menu_sync_status" AS ENUM('pending', 'synced', 'failed', 'out_of_sync');--> statement-breakpoint
CREATE TYPE "public"."notification_channel" AS ENUM('sms', 'email', 'push', 'whatsapp', 'in_app');--> statement-breakpoint
CREATE TYPE "public"."notification_status" AS ENUM('pending', 'sent', 'delivered', 'failed', 'skipped');--> statement-breakpoint
CREATE TYPE "public"."order_item_status" AS ENUM('pending', 'preparing', 'ready', 'served', 'cancelled', 'voided');--> statement-breakpoint
CREATE TYPE "public"."order_source" AS ENUM('pos', 'online', 'qr', 'kiosk', 'whatsapp', 'aggregator', 'group');--> statement-breakpoint
CREATE TYPE "public"."order_status" AS ENUM('pending', 'confirmed', 'preparing', 'ready', 'out_for_delivery', 'delivered', 'completed', 'cancelled', 'rejected', 'scheduled');--> statement-breakpoint
CREATE TYPE "public"."order_type" AS ENUM('dine_in', 'takeaway', 'delivery', 'catering');--> statement-breakpoint
CREATE TYPE "public"."outbox_status" AS ENUM('pending', 'published', 'failed');--> statement-breakpoint
CREATE TYPE "public"."payment_gateway" AS ENUM('manual', 'stripe', 'checkout', 'jazzcash', 'easypaisa', 'internal_wallet');--> statement-breakpoint
CREATE TYPE "public"."payment_method" AS ENUM('cash', 'card', 'jazzcash', 'easypaisa', 'nayapay', 'sadapay', 'bank_transfer', 'wallet', 'loyalty', 'complementary');--> statement-breakpoint
CREATE TYPE "public"."payment_status" AS ENUM('unpaid', 'partial', 'paid', 'refunded', 'partially_refunded', 'failed');--> statement-breakpoint
CREATE TYPE "public"."platform_role" AS ENUM('super_admin', 'support');--> statement-breakpoint
CREATE TYPE "public"."qr_type" AS ENUM('table', 'pickup_counter', 'takeaway', 'menu_only');--> statement-breakpoint
CREATE TYPE "public"."referral_status" AS ENUM('pending', 'converted', 'rewarded', 'expired');--> statement-breakpoint
CREATE TYPE "public"."refund_method" AS ENUM('original_payment', 'wallet', 'cash');--> statement-breakpoint
CREATE TYPE "public"."refund_status" AS ENUM('pending', 'processing', 'succeeded', 'failed');--> statement-breakpoint
CREATE TYPE "public"."reservation_status" AS ENUM('pending', 'confirmed', 'seated', 'completed', 'cancelled', 'no_show');--> statement-breakpoint
CREATE TYPE "public"."role_scope" AS ENUM('tenant', 'location', 'brand');--> statement-breakpoint
CREATE TYPE "public"."selection_type" AS ENUM('single', 'multiple', 'exactly');--> statement-breakpoint
CREATE TYPE "public"."sentiment" AS ENUM('positive', 'neutral', 'negative');--> statement-breakpoint
CREATE TYPE "public"."subscription_status" AS ENUM('trialing', 'active', 'past_due', 'paused', 'cancelled');--> statement-breakpoint
CREATE TYPE "public"."supplier_status" AS ENUM('active', 'inactive', 'on_hold');--> statement-breakpoint
CREATE TYPE "public"."tax_type" AS ENUM('gst', 'service_tax', 'fbr_pos', 'srb', 'vat', 'zatca', 'custom');--> statement-breakpoint
CREATE TYPE "public"."tenant_status" AS ENUM('trial', 'active', 'suspended', 'cancelled');--> statement-breakpoint
CREATE TYPE "public"."vehicle_type" AS ENUM('motorcycle', 'bicycle', 'car', 'van', 'foot');--> statement-breakpoint
CREATE TYPE "public"."wallet_transaction_type" AS ENUM('topup', 'spend', 'refund', 'adjust', 'expire');--> statement-breakpoint
CREATE TABLE "aggregator_integrations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid,
	"aggregator_name" varchar(50) NOT NULL,
	"api_key_encrypted" text,
	"store_id" varchar(255),
	"external_branch_id" varchar(255),
	"menu_sync_status" "menu_sync_status" DEFAULT 'pending',
	"auto_accept_orders" boolean DEFAULT false NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"last_menu_sync_at" timestamp with time zone,
	"last_order_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "aggregator_item_mappings" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"aggregator_integration_id" uuid NOT NULL,
	"menu_item_id" uuid NOT NULL,
	"aggregator_item_id" varchar(255),
	"aggregator_item_name" varchar(255),
	"aggregator_price" numeric(12, 2),
	"is_synced" boolean DEFAULT false NOT NULL,
	"is_available_on_aggregator" boolean DEFAULT true NOT NULL,
	"last_synced_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE "ai_churn_scores" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"customer_id" uuid NOT NULL,
	"churn_score" numeric(5, 4) NOT NULL,
	"days_since_last_order" integer,
	"avg_order_frequency_days" numeric(8, 2),
	"recommended_action" varchar(100),
	"win_back_offer_id" uuid,
	"computed_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "ai_demand_forecasts" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"forecast_date" date NOT NULL,
	"forecast_hour" smallint NOT NULL,
	"predicted_orders" integer,
	"predicted_revenue" numeric(12, 2),
	"confidence_score" numeric(5, 4),
	"model_version" varchar(50),
	"computed_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "ai_item_affinities" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid,
	"source_item_id" uuid NOT NULL,
	"target_item_id" uuid NOT NULL,
	"affinity_score" numeric(8, 6) NOT NULL,
	"co_occurrence_count" integer NOT NULL,
	"lift_score" numeric(8, 4),
	"computed_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "api_keys" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"created_by" uuid,
	"key_prefix" varchar(10) NOT NULL,
	"key_hash" varchar(255) NOT NULL,
	"name" varchar(255) NOT NULL,
	"scopes" text[],
	"is_active" boolean DEFAULT true NOT NULL,
	"last_used_at" timestamp with time zone,
	"expires_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "audit_logs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"user_id" uuid,
	"location_id" uuid,
	"entity_type" varchar(50) NOT NULL,
	"entity_id" uuid,
	"action" "audit_action" NOT NULL,
	"before_state" jsonb,
	"after_state" jsonb,
	"ip_address" varchar(45),
	"user_agent" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "brands" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"slug" varchar(120) NOT NULL,
	"logo_url" text,
	"banner_url" text,
	"primary_color" varchar(7),
	"secondary_color" varchar(7),
	"cuisine_type" varchar(100),
	"description" text,
	"meta_title" varchar(255),
	"meta_description" text,
	"custom_domain" varchar(255),
	"custom_domain_verified_at" timestamp with time zone,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "cart_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"customer_id" uuid,
	"session_token" varchar(255) NOT NULL,
	"order_source" "order_source",
	"order_type" "order_type",
	"qr_code_id" uuid,
	"group_session_id" uuid,
	"kiosk_terminal_id" uuid,
	"delivery_address_id" uuid,
	"scheduled_for" timestamp with time zone,
	"cart_items" jsonb DEFAULT '[]' NOT NULL,
	"promo_code" varchar(100),
	"applied_referral_code" varchar(30),
	"status" varchar(30) DEFAULT 'active' NOT NULL,
	"expires_at" timestamp with time zone,
	"converted_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "customer_addresses" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"customer_id" uuid NOT NULL,
	"tenant_id" uuid NOT NULL,
	"label" varchar(50),
	"full_name" varchar(255),
	"phone" varchar(50),
	"address_line1" varchar(255),
	"address_line2" varchar(255),
	"landmark" varchar(255),
	"area" varchar(150),
	"city" varchar(150),
	"state" varchar(150),
	"postal_code" varchar(20),
	"country_code" varchar(10) DEFAULT 'PK',
	"latitude" numeric(10, 7),
	"longitude" numeric(10, 7),
	"is_default" boolean DEFAULT false NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "customer_otps" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"customer_id" uuid,
	"phone" varchar(50) NOT NULL,
	"channel" "notification_channel" NOT NULL,
	"otp_hash" varchar(255) NOT NULL,
	"purpose" varchar(50) NOT NULL,
	"attempts" integer DEFAULT 0 NOT NULL,
	"is_used" boolean DEFAULT false NOT NULL,
	"expires_at" timestamp with time zone NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "customers" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"full_name" varchar(255),
	"email" varchar(255),
	"phone" varchar(50) NOT NULL,
	"password_hash" text,
	"auth_provider" "auth_provider" DEFAULT 'phone',
	"auth_provider_id" varchar(255),
	"gender" varchar(20),
	"date_of_birth" date,
	"email_verified" boolean DEFAULT false NOT NULL,
	"phone_verified" boolean DEFAULT false NOT NULL,
	"preferred_language" varchar(10) DEFAULT 'en',
	"marketing_opt_in" boolean DEFAULT false NOT NULL,
	"sms_opt_in" boolean DEFAULT false NOT NULL,
	"whatsapp_opt_in" boolean DEFAULT false NOT NULL,
	"cached_loyalty_points" numeric(12, 2) DEFAULT '0' NOT NULL,
	"cached_wallet_balance" numeric(12, 2) DEFAULT '0' NOT NULL,
	"total_orders" integer DEFAULT 0 NOT NULL,
	"total_spent" numeric(12, 2) DEFAULT '0' NOT NULL,
	"customer_segment" varchar(30),
	"last_order_at" timestamp with time zone,
	"referral_code" varchar(30),
	"referred_by_customer_id" uuid,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "daily_order_counters" (
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"date" date NOT NULL,
	"last_seq" integer DEFAULT 0 NOT NULL,
	CONSTRAINT "daily_order_counters_tenant_id_location_id_date_pk" PRIMARY KEY("tenant_id","location_id","date")
);
--> statement-breakpoint
CREATE TABLE "deliveries" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"order_id" uuid NOT NULL,
	"driver_id" uuid,
	"location_id" uuid,
	"delivery_zone_id" uuid,
	"status" "delivery_status" DEFAULT 'pending' NOT NULL,
	"pickup_latitude" numeric(10, 7),
	"pickup_longitude" numeric(10, 7),
	"dropoff_latitude" numeric(10, 7),
	"dropoff_longitude" numeric(10, 7),
	"dropoff_address_snapshot" text,
	"estimated_minutes" integer,
	"actual_minutes" integer,
	"distance_km" numeric(8, 2),
	"tracking_token" varchar(255) NOT NULL,
	"delivery_notes" text,
	"failure_reason" text,
	"proof_of_delivery_url" text,
	"assigned_at" timestamp with time zone,
	"picked_up_at" timestamp with time zone,
	"delivered_at" timestamp with time zone,
	"failed_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "delivery_tracking_history" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"delivery_id" uuid NOT NULL,
	"latitude" numeric(10, 7) NOT NULL,
	"longitude" numeric(10, 7) NOT NULL,
	"speed_kmh" integer,
	"heading" integer,
	"recorded_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "delivery_zones" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"location_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"polygon_coordinates" jsonb,
	"min_order_amount" numeric(12, 2),
	"delivery_fee" numeric(12, 2) NOT NULL,
	"free_delivery_above" numeric(12, 2),
	"estimated_min_minutes" integer,
	"estimated_max_minutes" integer,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "discount_redemptions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"discount_id" uuid NOT NULL,
	"order_id" uuid NOT NULL,
	"customer_id" uuid,
	"location_id" uuid,
	"amount_saved" numeric(12, 2) NOT NULL,
	"redeemed_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "discounts" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid,
	"name" varchar(255) NOT NULL,
	"code" varchar(100) NOT NULL,
	"discount_type" "discount_type" NOT NULL,
	"value" numeric(12, 2) NOT NULL,
	"max_discount_cap" numeric(12, 2),
	"min_order_amount" numeric(12, 2),
	"applicable_order_types" "order_type"[],
	"applicable_channels" "order_source"[],
	"max_total_uses" integer,
	"max_uses_per_customer" integer,
	"current_uses_cache" integer DEFAULT 0 NOT NULL,
	"is_first_order_only" boolean DEFAULT false NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"valid_from" date,
	"valid_to" date,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "drivers" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid,
	"full_name" varchar(255) NOT NULL,
	"phone" varchar(50) NOT NULL,
	"cnic" varchar(20),
	"vehicle_type" "vehicle_type",
	"vehicle_number" varchar(100),
	"vehicle_color" varchar(50),
	"status" "driver_status" DEFAULT 'offline' NOT NULL,
	"current_latitude" numeric(10, 7),
	"current_longitude" numeric(10, 7),
	"fcm_token" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"total_deliveries" integer DEFAULT 0 NOT NULL,
	"avg_rating" numeric(4, 2),
	"last_location_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "fbr_invoices" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid,
	"order_id" uuid,
	"fbr_invoice_number" varchar(120) NOT NULL,
	"fbr_pos_id" varchar(100),
	"invoice_amount" numeric(12, 2),
	"fbr_pos_charge" numeric(12, 2),
	"fbr_pos_charge_rate" numeric(8, 4),
	"payment_mode" "payment_method",
	"status" "fbr_status" DEFAULT 'pending' NOT NULL,
	"fbr_response_raw" jsonb,
	"transmitted_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "group_order_participants" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"session_id" uuid NOT NULL,
	"customer_id" uuid,
	"participant_name" varchar(255),
	"status" varchar(30) DEFAULT 'browsing' NOT NULL,
	"cart_items" jsonb,
	"subtotal" numeric(12, 2),
	"submitted_at" timestamp with time zone,
	"joined_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "group_order_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"host_customer_id" uuid,
	"session_token" varchar(255) NOT NULL,
	"share_link" varchar(255) NOT NULL,
	"status" "group_session_status" DEFAULT 'open' NOT NULL,
	"order_type" "order_type",
	"delivery_address_id" uuid,
	"max_participants" integer,
	"current_participants" integer DEFAULT 0 NOT NULL,
	"expires_at" timestamp with time zone,
	"locked_at" timestamp with time zone,
	"ordered_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "ingredients" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"sku" varchar(120),
	"uom" varchar(50) NOT NULL,
	"cost_per_unit" numeric(12, 4),
	"preferred_supplier_id" uuid,
	"reorder_threshold" numeric(12, 4),
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "inventory_stock" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"ingredient_id" uuid NOT NULL,
	"current_stock" numeric(12, 4) DEFAULT '0' NOT NULL,
	"last_counted_at" timestamp with time zone,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "inventory_transactions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"ingredient_id" uuid NOT NULL,
	"type" "inventory_transaction_type" NOT NULL,
	"quantity" numeric(12, 4) NOT NULL,
	"unit_cost" numeric(12, 4),
	"reference_type" varchar(50),
	"reference_id" uuid,
	"notes" text,
	"created_by" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "kiosk_terminals" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"identifier" varchar(120) NOT NULL,
	"name" varchar(255),
	"status" varchar(30) DEFAULT 'active' NOT NULL,
	"last_active_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "location_holiday_hours" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"location_id" uuid NOT NULL,
	"holiday_date" date NOT NULL,
	"is_closed" boolean DEFAULT true NOT NULL,
	"open_time" time,
	"close_time" time,
	"reason" varchar(100)
);
--> statement-breakpoint
CREATE TABLE "location_hours" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"location_id" uuid NOT NULL,
	"day_of_week" smallint NOT NULL,
	"is_closed" boolean DEFAULT false NOT NULL,
	"open_time" time,
	"close_time" time,
	"last_order_time" time,
	"delivery_start_time" time,
	"delivery_end_time" time,
	"pickup_start_time" time,
	"pickup_end_time" time
);
--> statement-breakpoint
CREATE TABLE "location_settings" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"location_id" uuid NOT NULL,
	"pickup_enabled" boolean DEFAULT false NOT NULL,
	"delivery_enabled" boolean DEFAULT false NOT NULL,
	"dine_in_enabled" boolean DEFAULT false NOT NULL,
	"qr_ordering_enabled" boolean DEFAULT false NOT NULL,
	"kiosk_ordering_enabled" boolean DEFAULT false NOT NULL,
	"whatsapp_ordering_enabled" boolean DEFAULT false NOT NULL,
	"scheduled_orders_enabled" boolean DEFAULT false NOT NULL,
	"group_ordering_enabled" boolean DEFAULT false NOT NULL,
	"tips_enabled" boolean DEFAULT false NOT NULL,
	"tip_pct_option1" numeric(5, 2),
	"tip_pct_option2" numeric(5, 2),
	"tip_pct_option3" numeric(5, 2),
	"service_charge_enabled" boolean DEFAULT false NOT NULL,
	"service_charge_rate" numeric(5, 2),
	"loyalty_enabled" boolean DEFAULT false NOT NULL,
	"wallet_enabled" boolean DEFAULT false NOT NULL,
	"referrals_enabled" boolean DEFAULT false NOT NULL,
	"fbr_enabled" boolean DEFAULT false NOT NULL,
	"fbr_pos_charge_rate" numeric(5, 2),
	"srb_enabled" boolean DEFAULT false NOT NULL,
	"srb_rate" numeric(5, 2),
	"tax_inclusive_pricing" boolean DEFAULT false NOT NULL,
	"min_pickup_wait_minutes" integer DEFAULT 15,
	"min_delivery_wait_minutes" integer DEFAULT 30,
	"min_order_amount_pickup" numeric(12, 2),
	"min_order_amount_delivery" numeric(12, 2),
	"min_order_amount_dine_in" numeric(12, 2),
	"max_schedule_days_ahead" integer DEFAULT 7,
	"max_active_orders" integer,
	"is_accepting_orders" boolean DEFAULT true NOT NULL,
	"is_temporarily_closed" boolean DEFAULT false NOT NULL,
	"temporarily_closed_message" text,
	"accepting_orders_until" timestamp with time zone,
	"receipt_footer_text" text,
	"ordering_page_banner_url" text,
	"ordering_page_announcement" text,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "locations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"brand_id" uuid,
	"name" varchar(255) NOT NULL,
	"slug" varchar(120) NOT NULL,
	"code" varchar(100) NOT NULL,
	"status" "location_status" DEFAULT 'active' NOT NULL,
	"location_type" "location_type",
	"address_line1" varchar(255),
	"address_line2" varchar(255),
	"area" varchar(150),
	"city" varchar(150),
	"state" varchar(150),
	"postal_code" varchar(20),
	"country_code" varchar(10) DEFAULT 'PK' NOT NULL,
	"phone" varchar(50),
	"email" varchar(255),
	"whatsapp_number" varchar(50),
	"timezone" varchar(100) DEFAULT 'Asia/Karachi' NOT NULL,
	"currency" varchar(10) DEFAULT 'PKR' NOT NULL,
	"latitude" numeric(10, 7),
	"longitude" numeric(10, 7),
	"google_maps_url" text,
	"google_place_id" varchar(255),
	"fbr_pos_id" varchar(100),
	"srb_registration_number" varchar(100),
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "loyalty_config" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"is_active" boolean DEFAULT false NOT NULL,
	"points_per_currency_unit" numeric(12, 4) DEFAULT '1' NOT NULL,
	"point_redemption_value" numeric(12, 4) DEFAULT '0.01' NOT NULL,
	"min_redeem_points" integer DEFAULT 100,
	"max_redeem_pct_per_order" numeric(5, 2) DEFAULT '50',
	"points_expiry_days" integer,
	"earn_on_delivery_fee" boolean DEFAULT false NOT NULL,
	"earn_on_tax" boolean DEFAULT false NOT NULL,
	"earn_on_discounted_orders" boolean DEFAULT false NOT NULL,
	"tiers_enabled" boolean DEFAULT false NOT NULL,
	"tiers_config" jsonb,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "loyalty_ledger" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"customer_id" uuid NOT NULL,
	"order_id" uuid,
	"type" "loyalty_transaction_type" NOT NULL,
	"points" numeric(12, 2) NOT NULL,
	"description" text,
	"expires_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "menu_categories" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"menu_id" uuid NOT NULL,
	"parent_id" uuid,
	"name" varchar(255) NOT NULL,
	"slug" varchar(255) NOT NULL,
	"description" text,
	"image_url" text,
	"display_order" integer DEFAULT 0 NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"available_from" time,
	"available_to" time,
	"available_order_types" "order_type"[],
	"deleted_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE "menu_item_ingredients" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"menu_item_id" uuid NOT NULL,
	"ingredient_id" uuid NOT NULL,
	"quantity_per_unit" numeric(12, 4) NOT NULL,
	"uom" varchar(50) NOT NULL
);
--> statement-breakpoint
CREATE TABLE "menu_item_location_overrides" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"menu_item_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"price_override" numeric(12, 2),
	"discount_price_override" numeric(12, 2),
	"stock_quantity" integer,
	"is_available" boolean DEFAULT true NOT NULL,
	"is_eighty_six" boolean DEFAULT false NOT NULL,
	"is_in_stock" boolean DEFAULT true NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "menu_item_modifier_groups" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"menu_item_id" uuid NOT NULL,
	"modifier_group_id" uuid NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE "menu_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"category_id" uuid NOT NULL,
	"tax_class_id" uuid,
	"sku" varchar(120) NOT NULL,
	"name" varchar(255) NOT NULL,
	"slug" varchar(255) NOT NULL,
	"description" text,
	"image_url" text,
	"thumbnail_url" text,
	"tags" text[],
	"uom" varchar(50) DEFAULT 'piece',
	"base_price" numeric(12, 2) NOT NULL,
	"compare_at_price" numeric(12, 2),
	"discount_price" numeric(12, 2),
	"prep_time_seconds" integer,
	"allergens" text[],
	"dietary_tags" text[],
	"calories" integer,
	"available_order_types" "order_type"[],
	"is_active" boolean DEFAULT true NOT NULL,
	"is_eighty_six" boolean DEFAULT false NOT NULL,
	"is_featured" boolean DEFAULT false NOT NULL,
	"is_stock_product" boolean DEFAULT false NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"popularity_score" numeric(8, 4),
	"deleted_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "menu_location_assignments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"menu_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"days_active" smallint[],
	"available_from" time,
	"available_to" time,
	"is_active" boolean DEFAULT true NOT NULL
);
--> statement-breakpoint
CREATE TABLE "menus" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"brand_id" uuid,
	"name" varchar(255) NOT NULL,
	"status" "menu_status" DEFAULT 'draft' NOT NULL,
	"is_default" boolean DEFAULT false NOT NULL,
	"published_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "modifier_groups" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"selection_type" "selection_type" DEFAULT 'single' NOT NULL,
	"min_selections" integer DEFAULT 0 NOT NULL,
	"max_selections" integer,
	"is_required" boolean DEFAULT false NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"deleted_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE "modifier_location_overrides" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"modifier_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"price_delta_override" numeric(12, 2),
	"is_available" boolean DEFAULT true NOT NULL,
	"is_in_stock" boolean DEFAULT true NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "modifiers" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"modifier_group_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"sku" varchar(120),
	"price_delta" numeric(12, 2) DEFAULT '0' NOT NULL,
	"calories_delta" integer,
	"display_order" integer DEFAULT 0 NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"deleted_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE "notification_templates" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"event_type" varchar(100) NOT NULL,
	"channel" "notification_channel" NOT NULL,
	"language" varchar(10) DEFAULT 'en' NOT NULL,
	"subject" varchar(255),
	"body_template" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "notifications" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"order_id" uuid,
	"customer_id" uuid,
	"location_id" uuid,
	"channel" "notification_channel" NOT NULL,
	"event_type" varchar(100) NOT NULL,
	"recipient" varchar(255) NOT NULL,
	"content" text,
	"status" "notification_status" DEFAULT 'pending' NOT NULL,
	"retry_count" integer DEFAULT 0 NOT NULL,
	"failure_reason" text,
	"scheduled_at" timestamp with time zone,
	"sent_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "online_order_item_modifiers" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"order_item_id" uuid NOT NULL,
	"modifier_id" uuid,
	"modifier_name_snapshot" varchar(255) NOT NULL,
	"group_name_snapshot" varchar(255),
	"price_delta_snapshot" numeric(12, 2) NOT NULL,
	"quantity" integer DEFAULT 1 NOT NULL
);
--> statement-breakpoint
CREATE TABLE "online_order_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"order_id" uuid NOT NULL,
	"menu_item_id" uuid,
	"item_name_snapshot" varchar(255) NOT NULL,
	"item_sku_snapshot" varchar(120),
	"unit_price_snapshot" numeric(12, 2) NOT NULL,
	"discount_price_snapshot" numeric(12, 2),
	"quantity" integer NOT NULL,
	"modifier_total" numeric(12, 2) DEFAULT '0' NOT NULL,
	"line_discount" numeric(12, 2) DEFAULT '0' NOT NULL,
	"line_total" numeric(12, 2) NOT NULL,
	"special_instructions" text,
	"status" "order_item_status" DEFAULT 'pending' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "online_order_status_logs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"order_id" uuid NOT NULL,
	"changed_by" uuid,
	"actor_type" "actor_type",
	"from_status" "order_status",
	"to_status" "order_status" NOT NULL,
	"note" text,
	"ip_address" varchar(45),
	"changed_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "online_orders" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"customer_id" uuid,
	"delivery_address_id" uuid,
	"delivery_zone_id" uuid,
	"discount_id" uuid,
	"qr_code_id" uuid,
	"group_session_id" uuid,
	"kiosk_terminal_id" uuid,
	"order_number" varchar(120) NOT NULL,
	"order_type" "order_type" NOT NULL,
	"order_source" "order_source" NOT NULL,
	"table_number" varchar(50),
	"aggregator_name" varchar(50),
	"aggregator_order_id" varchar(255),
	"status" "order_status" DEFAULT 'pending' NOT NULL,
	"payment_status" "payment_status" DEFAULT 'unpaid' NOT NULL,
	"cancelled_by" uuid,
	"cancelled_by_type" "actor_type",
	"cancellation_reason" varchar(255),
	"kitchen_notes" text,
	"subtotal" numeric(12, 2) NOT NULL,
	"discount_amount" numeric(12, 2) DEFAULT '0' NOT NULL,
	"delivery_fee" numeric(12, 2) DEFAULT '0' NOT NULL,
	"tax_amount" numeric(12, 2) DEFAULT '0' NOT NULL,
	"tip_amount" numeric(12, 2) DEFAULT '0' NOT NULL,
	"service_charge" numeric(12, 2) DEFAULT '0' NOT NULL,
	"wallet_amount_used" numeric(12, 2) DEFAULT '0' NOT NULL,
	"loyalty_amount_used" numeric(12, 2) DEFAULT '0' NOT NULL,
	"total" numeric(12, 2) NOT NULL,
	"currency" varchar(10) DEFAULT 'PKR' NOT NULL,
	"fbr_pos_charge" numeric(12, 2),
	"fbr_pos_charge_rate" numeric(8, 4),
	"fbr_invoice_number" varchar(120),
	"srb_tax_amount" numeric(12, 2),
	"customer_notes" text,
	"internal_notes" text,
	"estimated_prep_minutes" integer,
	"scheduled_for" timestamp with time zone,
	"is_pre_order" boolean DEFAULT false NOT NULL,
	"confirmed_at" timestamp with time zone,
	"preparing_at" timestamp with time zone,
	"ready_at" timestamp with time zone,
	"out_for_delivery_at" timestamp with time zone,
	"delivered_at" timestamp with time zone,
	"daily_ticket" integer,
	"cancelled_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "order_ratings" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"order_id" uuid NOT NULL,
	"customer_id" uuid,
	"location_id" uuid,
	"driver_id" uuid,
	"food_rating" integer,
	"delivery_rating" integer,
	"packaging_rating" integer,
	"app_experience_rating" integer,
	"overall_rating" integer,
	"review_text" text,
	"sentiment" "sentiment",
	"is_published" boolean DEFAULT false NOT NULL,
	"flagged_for_review" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "outbox_events" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"aggregate_type" varchar(50) NOT NULL,
	"aggregate_id" uuid NOT NULL,
	"event_type" varchar(100) NOT NULL,
	"payload" jsonb NOT NULL,
	"status" "outbox_status" DEFAULT 'pending' NOT NULL,
	"retry_count" integer DEFAULT 0 NOT NULL,
	"next_retry_at" timestamp with time zone,
	"published_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "password_reset_tokens" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"token_hash" varchar(255) NOT NULL,
	"is_used" boolean DEFAULT false NOT NULL,
	"expires_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "payments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"order_id" uuid,
	"customer_id" uuid,
	"location_id" uuid,
	"payment_method" "payment_method" NOT NULL,
	"payment_gateway" "payment_gateway" NOT NULL,
	"gateway_payment_id" varchar(255),
	"amount" numeric(12, 2) NOT NULL,
	"tip_amount" numeric(12, 2) DEFAULT '0',
	"refunded_amount" numeric(12, 2) DEFAULT '0' NOT NULL,
	"currency" varchar(10) DEFAULT 'PKR' NOT NULL,
	"card_last4" varchar(4),
	"card_brand" varchar(30),
	"mobile_wallet_number" varchar(50),
	"status" varchar(30) DEFAULT 'pending' NOT NULL,
	"gateway_response" jsonb,
	"authorized_at" timestamp with time zone,
	"captured_at" timestamp with time zone,
	"failed_at" timestamp with time zone,
	"refunded_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "plan_change_logs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"old_plan_id" uuid,
	"new_plan_id" uuid,
	"change_type" "change_type" NOT NULL,
	"changed_by" uuid,
	"proration_amount" numeric(12, 2),
	"effective_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "plans" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar(100) NOT NULL,
	"slug" varchar(120) NOT NULL,
	"description" text,
	"monthly_price" numeric(12, 2),
	"annual_price" numeric(12, 2),
	"max_locations" integer,
	"max_users" integer,
	"max_terminals" integer,
	"max_menu_items" integer,
	"max_brands" integer,
	"max_orders_per_month" integer,
	"feat_online_ordering" boolean DEFAULT false NOT NULL,
	"feat_multi_branch" boolean DEFAULT false NOT NULL,
	"feat_delivery_mgmt" boolean DEFAULT false NOT NULL,
	"feat_qr_ordering" boolean DEFAULT false NOT NULL,
	"feat_kiosk_ordering" boolean DEFAULT false NOT NULL,
	"feat_whatsapp_ordering" boolean DEFAULT false NOT NULL,
	"feat_group_ordering" boolean DEFAULT false NOT NULL,
	"feat_scheduled_orders" boolean DEFAULT false NOT NULL,
	"feat_loyalty" boolean DEFAULT false NOT NULL,
	"feat_wallet" boolean DEFAULT false NOT NULL,
	"feat_referrals" boolean DEFAULT false NOT NULL,
	"feat_crm" boolean DEFAULT false NOT NULL,
	"feat_aggregator_sync" boolean DEFAULT false NOT NULL,
	"feat_advanced_analytics" boolean DEFAULT false NOT NULL,
	"feat_ai_insights" boolean DEFAULT false NOT NULL,
	"feat_inventory" boolean DEFAULT false NOT NULL,
	"feat_fbr_integration" boolean DEFAULT false NOT NULL,
	"feat_api_access" boolean DEFAULT false NOT NULL,
	"feat_white_label" boolean DEFAULT false NOT NULL,
	"feat_custom_domain" boolean DEFAULT false NOT NULL,
	"feat_customer_app" boolean DEFAULT false NOT NULL,
	"permission_cap" jsonb,
	"trial_days" integer DEFAULT 14 NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "platform_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"platform_user_id" uuid NOT NULL,
	"refresh_token_hash" varchar(255) NOT NULL,
	"ip_address" varchar(45),
	"user_agent" text,
	"rotated_at" timestamp with time zone,
	"revoked_at" timestamp with time zone,
	"expires_at" timestamp with time zone NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"last_used_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE "platform_users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"email" varchar(255) NOT NULL,
	"password_hash" text NOT NULL,
	"full_name" varchar(255) NOT NULL,
	"role" "platform_role" DEFAULT 'super_admin' NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"last_login_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "price_rules" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid,
	"menu_item_id" uuid,
	"name" varchar(255) NOT NULL,
	"rule_type" varchar(50) NOT NULL,
	"value" numeric(12, 2),
	"days_of_week" smallint[],
	"start_time" time,
	"end_time" time,
	"valid_from" date,
	"valid_to" date,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "purchase_order_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"purchase_order_id" uuid NOT NULL,
	"ingredient_id" uuid NOT NULL,
	"ordered_quantity" numeric(12, 4) NOT NULL,
	"received_quantity" numeric(12, 4) DEFAULT '0' NOT NULL,
	"unit_cost" numeric(12, 4),
	"line_total" numeric(12, 2)
);
--> statement-breakpoint
CREATE TABLE "purchase_orders" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"supplier_id" uuid NOT NULL,
	"po_number" varchar(120) NOT NULL,
	"status" varchar(30) DEFAULT 'draft' NOT NULL,
	"total_amount" numeric(12, 2),
	"notes" text,
	"expected_at" date,
	"received_at" timestamp with time zone,
	"created_by" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "qr_codes" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"qr_type" "qr_type" NOT NULL,
	"identifier" varchar(120) NOT NULL,
	"table_number" varchar(50),
	"table_label" varchar(100),
	"table_capacity" integer,
	"section_name" varchar(100),
	"qr_image_url" text,
	"short_url" varchar(255) NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"total_scans" integer DEFAULT 0 NOT NULL,
	"last_scanned_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "referral_programs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"is_active" boolean DEFAULT false NOT NULL,
	"referrer_reward_type" varchar(20),
	"referrer_reward_value" numeric(12, 2),
	"referee_reward_type" varchar(20),
	"referee_reward_value" numeric(12, 2),
	"min_referee_orders" integer DEFAULT 1 NOT NULL,
	"max_referrals_per_customer" integer,
	"program_ends_at" timestamp with time zone,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "referrals" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"program_id" uuid NOT NULL,
	"referrer_customer_id" uuid NOT NULL,
	"referee_customer_id" uuid,
	"referral_code" varchar(30) NOT NULL,
	"status" "referral_status" DEFAULT 'pending' NOT NULL,
	"referee_order_count" integer DEFAULT 0 NOT NULL,
	"rewarded_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "refunds" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"payment_id" uuid NOT NULL,
	"order_id" uuid,
	"initiated_by" uuid,
	"initiated_by_type" "actor_type",
	"amount" numeric(12, 2) NOT NULL,
	"reason" varchar(100),
	"status" "refund_status" DEFAULT 'pending' NOT NULL,
	"refund_method" "refund_method",
	"gateway_refund_id" varchar(255),
	"notes" text,
	"processed_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "reservations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"customer_id" uuid,
	"reservation_number" varchar(120) NOT NULL,
	"customer_name" varchar(255),
	"customer_phone" varchar(50),
	"customer_email" varchar(255),
	"party_size" integer NOT NULL,
	"reservation_date" date NOT NULL,
	"reservation_time" time NOT NULL,
	"duration_minutes" integer DEFAULT 90,
	"table_preference" varchar(50),
	"status" "reservation_status" DEFAULT 'pending' NOT NULL,
	"special_requests" text,
	"occasion" varchar(50),
	"source" varchar(30),
	"confirmed_at" timestamp with time zone,
	"cancelled_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "roles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"name" varchar(100) NOT NULL,
	"scope" "role_scope" NOT NULL,
	"is_system_role" boolean DEFAULT false NOT NULL,
	"permissions" jsonb DEFAULT '{}' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "scheduled_order_slots" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"location_id" uuid NOT NULL,
	"order_type" "order_type",
	"day_of_week" smallint NOT NULL,
	"slot_time" time NOT NULL,
	"max_orders_per_slot" integer,
	"slot_interval_minutes" integer DEFAULT 15,
	"is_active" boolean DEFAULT true NOT NULL
);
--> statement-breakpoint
CREATE TABLE "srb_invoices" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid,
	"order_id" uuid,
	"srb_invoice_number" varchar(120) NOT NULL,
	"srb_registration_number" varchar(100),
	"invoice_amount" numeric(12, 2),
	"srb_tax_amount" numeric(12, 2),
	"srb_tax_rate" numeric(8, 4),
	"status" "fbr_status" DEFAULT 'pending' NOT NULL,
	"srb_response_raw" jsonb,
	"transmitted_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "subscription_invoices" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"subscription_id" uuid NOT NULL,
	"invoice_number" varchar(120) NOT NULL,
	"subtotal" numeric(12, 2),
	"tax_amount" numeric(12, 2) DEFAULT '0',
	"total" numeric(12, 2),
	"amount_paid" numeric(12, 2) DEFAULT '0',
	"currency" varchar(10) DEFAULT 'PKR' NOT NULL,
	"status" "invoice_status" DEFAULT 'draft' NOT NULL,
	"payment_gateway_ref" varchar(255),
	"due_date" date,
	"paid_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "subscriptions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"plan_id" uuid,
	"status" "subscription_status" NOT NULL,
	"billing_cycle" "billing_cycle" NOT NULL,
	"base_amount" numeric(12, 2),
	"discount_amount" numeric(12, 2) DEFAULT '0',
	"final_amount" numeric(12, 2),
	"currency" varchar(10) DEFAULT 'PKR' NOT NULL,
	"payment_gateway_ref" varchar(255),
	"trial_ends_at" date,
	"current_period_start" date,
	"current_period_end" date,
	"cancelled_at" date,
	"cancellation_reason" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "suppliers" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"contact_name" varchar(255),
	"phone" varchar(50),
	"email" varchar(255),
	"address" text,
	"status" "supplier_status" DEFAULT 'active' NOT NULL,
	"notes" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "tax_classes" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"name" varchar(100) NOT NULL,
	"rate" numeric(8, 4) NOT NULL,
	"jurisdiction" varchar(100),
	"tax_type" "tax_type",
	"is_inclusive" boolean DEFAULT false NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL
);
--> statement-breakpoint
CREATE TABLE "tax_invoices" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid,
	"order_id" uuid,
	"tax_authority" varchar(50) NOT NULL,
	"country_code" varchar(10) NOT NULL,
	"invoice_number" varchar(120) NOT NULL,
	"invoice_amount" numeric(12, 2),
	"tax_amount" numeric(12, 2),
	"tax_rate" numeric(8, 4),
	"qr_code_data" text,
	"status" "fbr_status" DEFAULT 'pending' NOT NULL,
	"raw_response" jsonb,
	"transmitted_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "tenant_benchmarks" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"cuisine_type" varchar(100),
	"city" varchar(150),
	"country_code" varchar(10) DEFAULT 'PK' NOT NULL,
	"period_month" varchar(7) NOT NULL,
	"cohort_size" integer NOT NULL,
	"p25_avg_order_value" numeric(12, 2),
	"p50_avg_order_value" numeric(12, 2),
	"p75_avg_order_value" numeric(12, 2),
	"p50_repeat_order_rate" numeric(5, 4),
	"p50_avg_delivery_minutes" numeric(8, 2),
	"p50_cancellation_rate" numeric(5, 4),
	"computed_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "tenant_feature_usage" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"period_month" varchar(7) NOT NULL,
	"total_orders" integer DEFAULT 0 NOT NULL,
	"online_orders" integer DEFAULT 0 NOT NULL,
	"qr_orders" integer DEFAULT 0 NOT NULL,
	"whatsapp_orders" integer DEFAULT 0 NOT NULL,
	"kiosk_orders" integer DEFAULT 0 NOT NULL,
	"loyalty_redemptions" integer DEFAULT 0 NOT NULL,
	"wallet_topups" integer DEFAULT 0 NOT NULL,
	"aggregator_orders" integer DEFAULT 0 NOT NULL,
	"active_drivers" integer DEFAULT 0 NOT NULL,
	"unique_customers" integer DEFAULT 0 NOT NULL,
	"computed_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "tenants" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"plan_id" uuid,
	"business_name" varchar(255) NOT NULL,
	"slug" varchar(120) NOT NULL,
	"status" "tenant_status" DEFAULT 'trial' NOT NULL,
	"billing_email" varchar(255) NOT NULL,
	"billing_name" varchar(255),
	"tax_id" varchar(100),
	"ntn_number" varchar(100),
	"phone" varchar(50),
	"country_code" varchar(10) DEFAULT 'PK' NOT NULL,
	"default_timezone" varchar(100) DEFAULT 'Asia/Karachi' NOT NULL,
	"default_currency" varchar(10) DEFAULT 'PKR' NOT NULL,
	"default_language" varchar(10) DEFAULT 'en' NOT NULL,
	"cached_location_count" integer DEFAULT 0 NOT NULL,
	"cached_order_count_this_month" integer DEFAULT 0 NOT NULL,
	"feature_usage_snapshot" jsonb,
	"is_test_account" boolean DEFAULT false NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"trial_ends_at" timestamp with time zone,
	"activated_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "upsell_impressions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"order_id" uuid,
	"customer_id" uuid,
	"menu_item_id" uuid,
	"upsell_type" varchar(50),
	"was_added" boolean DEFAULT false NOT NULL,
	"item_price" numeric(12, 2),
	"shown_at" timestamp with time zone DEFAULT now() NOT NULL,
	"added_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE "user_location_access" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"role_id" uuid NOT NULL,
	"location_id" uuid,
	"assigned_at" timestamp with time zone DEFAULT now() NOT NULL,
	"expires_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE "user_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"active_location_id" uuid,
	"token_hash" varchar(255) NOT NULL,
	"refresh_token_hash" varchar(255),
	"device_type" varchar(30),
	"device_name" varchar(100),
	"ip_address" varchar(45),
	"user_agent" text,
	"last_active_at" timestamp with time zone,
	"expires_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"full_name" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"password_hash" text,
	"phone" varchar(50),
	"avatar_url" text,
	"email_verified" boolean DEFAULT false NOT NULL,
	"mfa_enabled" boolean DEFAULT false NOT NULL,
	"mfa_secret" varchar(255),
	"is_active" boolean DEFAULT true NOT NULL,
	"last_login_at" timestamp with time zone,
	"password_changed_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "wallet_ledger" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"customer_id" uuid NOT NULL,
	"order_id" uuid,
	"type" "wallet_transaction_type" NOT NULL,
	"amount" numeric(12, 2) NOT NULL,
	"description" varchar(255),
	"reference_type" varchar(50),
	"reference_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "whatsapp_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"tenant_id" uuid NOT NULL,
	"location_id" uuid NOT NULL,
	"customer_id" uuid,
	"wa_phone_number" varchar(50) NOT NULL,
	"session_state" varchar(50),
	"cart_data" jsonb,
	"order_type" "order_type",
	"delivery_address_id" uuid,
	"current_step" varchar(100),
	"last_message_at" timestamp with time zone,
	"expires_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "aggregator_integrations" ADD CONSTRAINT "aggregator_integrations_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "aggregator_integrations" ADD CONSTRAINT "aggregator_integrations_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "aggregator_item_mappings" ADD CONSTRAINT "aggregator_item_mappings_aggregator_integration_id_aggregator_integrations_id_fk" FOREIGN KEY ("aggregator_integration_id") REFERENCES "public"."aggregator_integrations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "aggregator_item_mappings" ADD CONSTRAINT "aggregator_item_mappings_menu_item_id_menu_items_id_fk" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_items"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ai_churn_scores" ADD CONSTRAINT "ai_churn_scores_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ai_churn_scores" ADD CONSTRAINT "ai_churn_scores_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ai_churn_scores" ADD CONSTRAINT "ai_churn_scores_win_back_offer_id_discounts_id_fk" FOREIGN KEY ("win_back_offer_id") REFERENCES "public"."discounts"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ai_demand_forecasts" ADD CONSTRAINT "ai_demand_forecasts_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ai_demand_forecasts" ADD CONSTRAINT "ai_demand_forecasts_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ai_item_affinities" ADD CONSTRAINT "ai_item_affinities_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ai_item_affinities" ADD CONSTRAINT "ai_item_affinities_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ai_item_affinities" ADD CONSTRAINT "ai_item_affinities_source_item_id_menu_items_id_fk" FOREIGN KEY ("source_item_id") REFERENCES "public"."menu_items"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ai_item_affinities" ADD CONSTRAINT "ai_item_affinities_target_item_id_menu_items_id_fk" FOREIGN KEY ("target_item_id") REFERENCES "public"."menu_items"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "api_keys" ADD CONSTRAINT "api_keys_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "api_keys" ADD CONSTRAINT "api_keys_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "brands" ADD CONSTRAINT "brands_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cart_sessions" ADD CONSTRAINT "cart_sessions_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cart_sessions" ADD CONSTRAINT "cart_sessions_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cart_sessions" ADD CONSTRAINT "cart_sessions_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cart_sessions" ADD CONSTRAINT "cart_sessions_qr_code_id_qr_codes_id_fk" FOREIGN KEY ("qr_code_id") REFERENCES "public"."qr_codes"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cart_sessions" ADD CONSTRAINT "cart_sessions_group_session_id_group_order_sessions_id_fk" FOREIGN KEY ("group_session_id") REFERENCES "public"."group_order_sessions"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cart_sessions" ADD CONSTRAINT "cart_sessions_kiosk_terminal_id_kiosk_terminals_id_fk" FOREIGN KEY ("kiosk_terminal_id") REFERENCES "public"."kiosk_terminals"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cart_sessions" ADD CONSTRAINT "cart_sessions_delivery_address_id_customer_addresses_id_fk" FOREIGN KEY ("delivery_address_id") REFERENCES "public"."customer_addresses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "customer_addresses" ADD CONSTRAINT "customer_addresses_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "customer_addresses" ADD CONSTRAINT "customer_addresses_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "customer_otps" ADD CONSTRAINT "customer_otps_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "customer_otps" ADD CONSTRAINT "customer_otps_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "customers" ADD CONSTRAINT "customers_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "daily_order_counters" ADD CONSTRAINT "daily_order_counters_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "daily_order_counters" ADD CONSTRAINT "daily_order_counters_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "deliveries" ADD CONSTRAINT "deliveries_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "deliveries" ADD CONSTRAINT "deliveries_driver_id_drivers_id_fk" FOREIGN KEY ("driver_id") REFERENCES "public"."drivers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "deliveries" ADD CONSTRAINT "deliveries_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "deliveries" ADD CONSTRAINT "deliveries_delivery_zone_id_delivery_zones_id_fk" FOREIGN KEY ("delivery_zone_id") REFERENCES "public"."delivery_zones"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "delivery_tracking_history" ADD CONSTRAINT "delivery_tracking_history_delivery_id_deliveries_id_fk" FOREIGN KEY ("delivery_id") REFERENCES "public"."deliveries"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "delivery_zones" ADD CONSTRAINT "delivery_zones_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "discount_redemptions" ADD CONSTRAINT "discount_redemptions_discount_id_discounts_id_fk" FOREIGN KEY ("discount_id") REFERENCES "public"."discounts"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "discount_redemptions" ADD CONSTRAINT "discount_redemptions_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "discount_redemptions" ADD CONSTRAINT "discount_redemptions_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "discount_redemptions" ADD CONSTRAINT "discount_redemptions_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "discounts" ADD CONSTRAINT "discounts_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "discounts" ADD CONSTRAINT "discounts_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "drivers" ADD CONSTRAINT "drivers_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "drivers" ADD CONSTRAINT "drivers_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "fbr_invoices" ADD CONSTRAINT "fbr_invoices_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "fbr_invoices" ADD CONSTRAINT "fbr_invoices_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "fbr_invoices" ADD CONSTRAINT "fbr_invoices_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "group_order_participants" ADD CONSTRAINT "group_order_participants_session_id_group_order_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."group_order_sessions"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "group_order_participants" ADD CONSTRAINT "group_order_participants_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "group_order_sessions" ADD CONSTRAINT "group_order_sessions_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "group_order_sessions" ADD CONSTRAINT "group_order_sessions_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "group_order_sessions" ADD CONSTRAINT "group_order_sessions_host_customer_id_customers_id_fk" FOREIGN KEY ("host_customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "group_order_sessions" ADD CONSTRAINT "group_order_sessions_delivery_address_id_customer_addresses_id_fk" FOREIGN KEY ("delivery_address_id") REFERENCES "public"."customer_addresses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ingredients" ADD CONSTRAINT "ingredients_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ingredients" ADD CONSTRAINT "ingredients_preferred_supplier_id_suppliers_id_fk" FOREIGN KEY ("preferred_supplier_id") REFERENCES "public"."suppliers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inventory_stock" ADD CONSTRAINT "inventory_stock_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inventory_stock" ADD CONSTRAINT "inventory_stock_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inventory_stock" ADD CONSTRAINT "inventory_stock_ingredient_id_ingredients_id_fk" FOREIGN KEY ("ingredient_id") REFERENCES "public"."ingredients"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inventory_transactions" ADD CONSTRAINT "inventory_transactions_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inventory_transactions" ADD CONSTRAINT "inventory_transactions_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inventory_transactions" ADD CONSTRAINT "inventory_transactions_ingredient_id_ingredients_id_fk" FOREIGN KEY ("ingredient_id") REFERENCES "public"."ingredients"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inventory_transactions" ADD CONSTRAINT "inventory_transactions_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "kiosk_terminals" ADD CONSTRAINT "kiosk_terminals_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "kiosk_terminals" ADD CONSTRAINT "kiosk_terminals_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "location_holiday_hours" ADD CONSTRAINT "location_holiday_hours_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "location_hours" ADD CONSTRAINT "location_hours_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "location_settings" ADD CONSTRAINT "location_settings_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "locations" ADD CONSTRAINT "locations_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "locations" ADD CONSTRAINT "locations_brand_id_brands_id_fk" FOREIGN KEY ("brand_id") REFERENCES "public"."brands"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "loyalty_config" ADD CONSTRAINT "loyalty_config_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "loyalty_ledger" ADD CONSTRAINT "loyalty_ledger_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "loyalty_ledger" ADD CONSTRAINT "loyalty_ledger_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "loyalty_ledger" ADD CONSTRAINT "loyalty_ledger_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_categories" ADD CONSTRAINT "menu_categories_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_categories" ADD CONSTRAINT "menu_categories_menu_id_menus_id_fk" FOREIGN KEY ("menu_id") REFERENCES "public"."menus"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_categories" ADD CONSTRAINT "menu_categories_parent_id_menu_categories_id_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."menu_categories"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_item_ingredients" ADD CONSTRAINT "menu_item_ingredients_menu_item_id_menu_items_id_fk" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_items"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_item_ingredients" ADD CONSTRAINT "menu_item_ingredients_ingredient_id_ingredients_id_fk" FOREIGN KEY ("ingredient_id") REFERENCES "public"."ingredients"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_item_location_overrides" ADD CONSTRAINT "menu_item_location_overrides_menu_item_id_menu_items_id_fk" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_items"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_item_location_overrides" ADD CONSTRAINT "menu_item_location_overrides_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_item_modifier_groups" ADD CONSTRAINT "menu_item_modifier_groups_menu_item_id_menu_items_id_fk" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_items"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_item_modifier_groups" ADD CONSTRAINT "menu_item_modifier_groups_modifier_group_id_modifier_groups_id_fk" FOREIGN KEY ("modifier_group_id") REFERENCES "public"."modifier_groups"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_items" ADD CONSTRAINT "menu_items_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_items" ADD CONSTRAINT "menu_items_category_id_menu_categories_id_fk" FOREIGN KEY ("category_id") REFERENCES "public"."menu_categories"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_items" ADD CONSTRAINT "menu_items_tax_class_id_tax_classes_id_fk" FOREIGN KEY ("tax_class_id") REFERENCES "public"."tax_classes"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_location_assignments" ADD CONSTRAINT "menu_location_assignments_menu_id_menus_id_fk" FOREIGN KEY ("menu_id") REFERENCES "public"."menus"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menu_location_assignments" ADD CONSTRAINT "menu_location_assignments_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menus" ADD CONSTRAINT "menus_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "menus" ADD CONSTRAINT "menus_brand_id_brands_id_fk" FOREIGN KEY ("brand_id") REFERENCES "public"."brands"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "modifier_groups" ADD CONSTRAINT "modifier_groups_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "modifier_location_overrides" ADD CONSTRAINT "modifier_location_overrides_modifier_id_modifiers_id_fk" FOREIGN KEY ("modifier_id") REFERENCES "public"."modifiers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "modifier_location_overrides" ADD CONSTRAINT "modifier_location_overrides_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "modifiers" ADD CONSTRAINT "modifiers_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "modifiers" ADD CONSTRAINT "modifiers_modifier_group_id_modifier_groups_id_fk" FOREIGN KEY ("modifier_group_id") REFERENCES "public"."modifier_groups"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notification_templates" ADD CONSTRAINT "notification_templates_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_order_item_modifiers" ADD CONSTRAINT "online_order_item_modifiers_order_item_id_online_order_items_id_fk" FOREIGN KEY ("order_item_id") REFERENCES "public"."online_order_items"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_order_item_modifiers" ADD CONSTRAINT "online_order_item_modifiers_modifier_id_modifiers_id_fk" FOREIGN KEY ("modifier_id") REFERENCES "public"."modifiers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_order_items" ADD CONSTRAINT "online_order_items_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_order_items" ADD CONSTRAINT "online_order_items_menu_item_id_menu_items_id_fk" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_items"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_order_status_logs" ADD CONSTRAINT "online_order_status_logs_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_orders" ADD CONSTRAINT "online_orders_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_orders" ADD CONSTRAINT "online_orders_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_orders" ADD CONSTRAINT "online_orders_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_orders" ADD CONSTRAINT "online_orders_delivery_address_id_customer_addresses_id_fk" FOREIGN KEY ("delivery_address_id") REFERENCES "public"."customer_addresses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_orders" ADD CONSTRAINT "online_orders_delivery_zone_id_delivery_zones_id_fk" FOREIGN KEY ("delivery_zone_id") REFERENCES "public"."delivery_zones"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_orders" ADD CONSTRAINT "online_orders_discount_id_discounts_id_fk" FOREIGN KEY ("discount_id") REFERENCES "public"."discounts"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_orders" ADD CONSTRAINT "online_orders_qr_code_id_qr_codes_id_fk" FOREIGN KEY ("qr_code_id") REFERENCES "public"."qr_codes"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_orders" ADD CONSTRAINT "online_orders_group_session_id_group_order_sessions_id_fk" FOREIGN KEY ("group_session_id") REFERENCES "public"."group_order_sessions"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "online_orders" ADD CONSTRAINT "online_orders_kiosk_terminal_id_kiosk_terminals_id_fk" FOREIGN KEY ("kiosk_terminal_id") REFERENCES "public"."kiosk_terminals"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "order_ratings" ADD CONSTRAINT "order_ratings_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "order_ratings" ADD CONSTRAINT "order_ratings_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "order_ratings" ADD CONSTRAINT "order_ratings_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "order_ratings" ADD CONSTRAINT "order_ratings_driver_id_drivers_id_fk" FOREIGN KEY ("driver_id") REFERENCES "public"."drivers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "password_reset_tokens" ADD CONSTRAINT "password_reset_tokens_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payments" ADD CONSTRAINT "payments_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payments" ADD CONSTRAINT "payments_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payments" ADD CONSTRAINT "payments_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payments" ADD CONSTRAINT "payments_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "plan_change_logs" ADD CONSTRAINT "plan_change_logs_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "plan_change_logs" ADD CONSTRAINT "plan_change_logs_old_plan_id_plans_id_fk" FOREIGN KEY ("old_plan_id") REFERENCES "public"."plans"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "plan_change_logs" ADD CONSTRAINT "plan_change_logs_new_plan_id_plans_id_fk" FOREIGN KEY ("new_plan_id") REFERENCES "public"."plans"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "plan_change_logs" ADD CONSTRAINT "plan_change_logs_changed_by_users_id_fk" FOREIGN KEY ("changed_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "platform_sessions" ADD CONSTRAINT "platform_sessions_platform_user_id_platform_users_id_fk" FOREIGN KEY ("platform_user_id") REFERENCES "public"."platform_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "price_rules" ADD CONSTRAINT "price_rules_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "price_rules" ADD CONSTRAINT "price_rules_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "price_rules" ADD CONSTRAINT "price_rules_menu_item_id_menu_items_id_fk" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_items"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_order_items" ADD CONSTRAINT "purchase_order_items_purchase_order_id_purchase_orders_id_fk" FOREIGN KEY ("purchase_order_id") REFERENCES "public"."purchase_orders"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_order_items" ADD CONSTRAINT "purchase_order_items_ingredient_id_ingredients_id_fk" FOREIGN KEY ("ingredient_id") REFERENCES "public"."ingredients"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_orders" ADD CONSTRAINT "purchase_orders_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_orders" ADD CONSTRAINT "purchase_orders_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_orders" ADD CONSTRAINT "purchase_orders_supplier_id_suppliers_id_fk" FOREIGN KEY ("supplier_id") REFERENCES "public"."suppliers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_orders" ADD CONSTRAINT "purchase_orders_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "qr_codes" ADD CONSTRAINT "qr_codes_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "qr_codes" ADD CONSTRAINT "qr_codes_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "referral_programs" ADD CONSTRAINT "referral_programs_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "referrals" ADD CONSTRAINT "referrals_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "referrals" ADD CONSTRAINT "referrals_program_id_referral_programs_id_fk" FOREIGN KEY ("program_id") REFERENCES "public"."referral_programs"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "referrals" ADD CONSTRAINT "referrals_referrer_customer_id_customers_id_fk" FOREIGN KEY ("referrer_customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "referrals" ADD CONSTRAINT "referrals_referee_customer_id_customers_id_fk" FOREIGN KEY ("referee_customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "refunds" ADD CONSTRAINT "refunds_payment_id_payments_id_fk" FOREIGN KEY ("payment_id") REFERENCES "public"."payments"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "refunds" ADD CONSTRAINT "refunds_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "reservations" ADD CONSTRAINT "reservations_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "reservations" ADD CONSTRAINT "reservations_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "reservations" ADD CONSTRAINT "reservations_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "roles" ADD CONSTRAINT "roles_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "scheduled_order_slots" ADD CONSTRAINT "scheduled_order_slots_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "srb_invoices" ADD CONSTRAINT "srb_invoices_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "srb_invoices" ADD CONSTRAINT "srb_invoices_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "srb_invoices" ADD CONSTRAINT "srb_invoices_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "subscription_invoices" ADD CONSTRAINT "subscription_invoices_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "subscription_invoices" ADD CONSTRAINT "subscription_invoices_subscription_id_subscriptions_id_fk" FOREIGN KEY ("subscription_id") REFERENCES "public"."subscriptions"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE restrict ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_plan_id_plans_id_fk" FOREIGN KEY ("plan_id") REFERENCES "public"."plans"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "suppliers" ADD CONSTRAINT "suppliers_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tax_classes" ADD CONSTRAINT "tax_classes_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tax_invoices" ADD CONSTRAINT "tax_invoices_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tax_invoices" ADD CONSTRAINT "tax_invoices_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tax_invoices" ADD CONSTRAINT "tax_invoices_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tenant_feature_usage" ADD CONSTRAINT "tenant_feature_usage_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tenants" ADD CONSTRAINT "tenants_plan_id_plans_id_fk" FOREIGN KEY ("plan_id") REFERENCES "public"."plans"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "upsell_impressions" ADD CONSTRAINT "upsell_impressions_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "upsell_impressions" ADD CONSTRAINT "upsell_impressions_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "upsell_impressions" ADD CONSTRAINT "upsell_impressions_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "upsell_impressions" ADD CONSTRAINT "upsell_impressions_menu_item_id_menu_items_id_fk" FOREIGN KEY ("menu_item_id") REFERENCES "public"."menu_items"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_location_access" ADD CONSTRAINT "user_location_access_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_location_access" ADD CONSTRAINT "user_location_access_role_id_roles_id_fk" FOREIGN KEY ("role_id") REFERENCES "public"."roles"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_location_access" ADD CONSTRAINT "user_location_access_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_sessions" ADD CONSTRAINT "user_sessions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_sessions" ADD CONSTRAINT "user_sessions_active_location_id_locations_id_fk" FOREIGN KEY ("active_location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "wallet_ledger" ADD CONSTRAINT "wallet_ledger_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "wallet_ledger" ADD CONSTRAINT "wallet_ledger_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "wallet_ledger" ADD CONSTRAINT "wallet_ledger_order_id_online_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."online_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "whatsapp_sessions" ADD CONSTRAINT "whatsapp_sessions_tenant_id_tenants_id_fk" FOREIGN KEY ("tenant_id") REFERENCES "public"."tenants"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "whatsapp_sessions" ADD CONSTRAINT "whatsapp_sessions_location_id_locations_id_fk" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "whatsapp_sessions" ADD CONSTRAINT "whatsapp_sessions_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "whatsapp_sessions" ADD CONSTRAINT "whatsapp_sessions_delivery_address_id_customer_addresses_id_fk" FOREIGN KEY ("delivery_address_id") REFERENCES "public"."customer_addresses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "agg_integrations_tenant_idx" ON "aggregator_integrations" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "agg_integrations_location_idx" ON "aggregator_integrations" USING btree ("location_id");--> statement-breakpoint
CREATE UNIQUE INDEX "agg_integrations_tenant_agg_location_uk" ON "aggregator_integrations" USING btree ("tenant_id","aggregator_name","location_id");--> statement-breakpoint
CREATE INDEX "agg_item_mappings_integration_idx" ON "aggregator_item_mappings" USING btree ("aggregator_integration_id");--> statement-breakpoint
CREATE INDEX "agg_item_mappings_menu_item_idx" ON "aggregator_item_mappings" USING btree ("menu_item_id");--> statement-breakpoint
CREATE UNIQUE INDEX "agg_item_mappings_integration_item_uk" ON "aggregator_item_mappings" USING btree ("aggregator_integration_id","menu_item_id");--> statement-breakpoint
CREATE UNIQUE INDEX "ai_churn_tenant_customer_uk" ON "ai_churn_scores" USING btree ("tenant_id","customer_id");--> statement-breakpoint
CREATE INDEX "ai_churn_tenant_idx" ON "ai_churn_scores" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "ai_churn_score_idx" ON "ai_churn_scores" USING btree ("tenant_id","churn_score");--> statement-breakpoint
CREATE UNIQUE INDEX "ai_forecasts_location_date_hour_uk" ON "ai_demand_forecasts" USING btree ("location_id","forecast_date","forecast_hour");--> statement-breakpoint
CREATE INDEX "ai_forecasts_tenant_idx" ON "ai_demand_forecasts" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "ai_affinities_tenant_idx" ON "ai_item_affinities" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "ai_affinities_source_idx" ON "ai_item_affinities" USING btree ("source_item_id");--> statement-breakpoint
CREATE UNIQUE INDEX "ai_affinities_pair_uk" ON "ai_item_affinities" USING btree ("tenant_id","location_id","source_item_id","target_item_id");--> statement-breakpoint
CREATE UNIQUE INDEX "api_keys_key_hash_uk" ON "api_keys" USING btree ("key_hash");--> statement-breakpoint
CREATE INDEX "api_keys_tenant_idx" ON "api_keys" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "audit_logs_tenant_idx" ON "audit_logs" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "audit_logs_user_idx" ON "audit_logs" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "audit_logs_entity_idx" ON "audit_logs" USING btree ("entity_type","entity_id");--> statement-breakpoint
CREATE INDEX "audit_logs_tenant_created_at_idx" ON "audit_logs" USING btree ("tenant_id","created_at");--> statement-breakpoint
CREATE INDEX "brands_tenant_idx" ON "brands" USING btree ("tenant_id");--> statement-breakpoint
CREATE UNIQUE INDEX "brands_tenant_slug_uk" ON "brands" USING btree ("tenant_id","slug");--> statement-breakpoint
CREATE UNIQUE INDEX "brands_custom_domain_uk" ON "brands" USING btree ("custom_domain");--> statement-breakpoint
CREATE UNIQUE INDEX "cart_sessions_token_uk" ON "cart_sessions" USING btree ("session_token");--> statement-breakpoint
CREATE INDEX "cart_sessions_tenant_idx" ON "cart_sessions" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "cart_sessions_location_idx" ON "cart_sessions" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "cart_sessions_customer_idx" ON "cart_sessions" USING btree ("customer_id");--> statement-breakpoint
CREATE INDEX "customer_addresses_customer_idx" ON "customer_addresses" USING btree ("customer_id");--> statement-breakpoint
CREATE INDEX "customer_addresses_tenant_idx" ON "customer_addresses" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "customer_otps_tenant_idx" ON "customer_otps" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "customer_otps_customer_idx" ON "customer_otps" USING btree ("customer_id");--> statement-breakpoint
CREATE UNIQUE INDEX "customers_tenant_phone_uk" ON "customers" USING btree ("tenant_id","phone");--> statement-breakpoint
CREATE INDEX "customers_tenant_idx" ON "customers" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "customers_segment_idx" ON "customers" USING btree ("tenant_id","customer_segment");--> statement-breakpoint
CREATE UNIQUE INDEX "customers_referral_code_uk" ON "customers" USING btree ("tenant_id","referral_code");--> statement-breakpoint
CREATE INDEX "daily_counter_tenant_idx" ON "daily_order_counters" USING btree ("tenant_id");--> statement-breakpoint
CREATE UNIQUE INDEX "deliveries_tracking_token_uk" ON "deliveries" USING btree ("tracking_token");--> statement-breakpoint
CREATE INDEX "deliveries_order_idx" ON "deliveries" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "deliveries_driver_idx" ON "deliveries" USING btree ("driver_id");--> statement-breakpoint
CREATE INDEX "deliveries_location_idx" ON "deliveries" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "deliveries_status_idx" ON "deliveries" USING btree ("status");--> statement-breakpoint
CREATE INDEX "tracking_history_delivery_idx" ON "delivery_tracking_history" USING btree ("delivery_id");--> statement-breakpoint
CREATE INDEX "tracking_history_recorded_at_idx" ON "delivery_tracking_history" USING btree ("delivery_id","recorded_at");--> statement-breakpoint
CREATE INDEX "delivery_zones_location_idx" ON "delivery_zones" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "discount_redemptions_discount_idx" ON "discount_redemptions" USING btree ("discount_id");--> statement-breakpoint
CREATE INDEX "discount_redemptions_order_idx" ON "discount_redemptions" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "discount_redemptions_customer_idx" ON "discount_redemptions" USING btree ("customer_id");--> statement-breakpoint
CREATE UNIQUE INDEX "discounts_tenant_code_uk" ON "discounts" USING btree ("tenant_id","code");--> statement-breakpoint
CREATE INDEX "discounts_tenant_idx" ON "discounts" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "discounts_location_idx" ON "discounts" USING btree ("location_id");--> statement-breakpoint
CREATE UNIQUE INDEX "drivers_tenant_phone_uk" ON "drivers" USING btree ("tenant_id","phone");--> statement-breakpoint
CREATE INDEX "drivers_tenant_idx" ON "drivers" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "drivers_location_idx" ON "drivers" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "drivers_status_idx" ON "drivers" USING btree ("tenant_id","status");--> statement-breakpoint
CREATE UNIQUE INDEX "fbr_invoices_number_uk" ON "fbr_invoices" USING btree ("fbr_invoice_number");--> statement-breakpoint
CREATE INDEX "fbr_invoices_tenant_idx" ON "fbr_invoices" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "fbr_invoices_order_idx" ON "fbr_invoices" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "group_participants_session_idx" ON "group_order_participants" USING btree ("session_id");--> statement-breakpoint
CREATE INDEX "group_participants_customer_idx" ON "group_order_participants" USING btree ("customer_id");--> statement-breakpoint
CREATE UNIQUE INDEX "group_sessions_token_uk" ON "group_order_sessions" USING btree ("session_token");--> statement-breakpoint
CREATE UNIQUE INDEX "group_sessions_share_link_uk" ON "group_order_sessions" USING btree ("share_link");--> statement-breakpoint
CREATE INDEX "group_sessions_tenant_idx" ON "group_order_sessions" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "group_sessions_location_idx" ON "group_order_sessions" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "ingredients_tenant_idx" ON "ingredients" USING btree ("tenant_id");--> statement-breakpoint
CREATE UNIQUE INDEX "ingredients_tenant_sku_uk" ON "ingredients" USING btree ("tenant_id","sku");--> statement-breakpoint
CREATE UNIQUE INDEX "inventory_stock_location_ingredient_uk" ON "inventory_stock" USING btree ("location_id","ingredient_id");--> statement-breakpoint
CREATE INDEX "inventory_stock_tenant_idx" ON "inventory_stock" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "inventory_stock_location_idx" ON "inventory_stock" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "inv_tx_tenant_idx" ON "inventory_transactions" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "inv_tx_location_idx" ON "inventory_transactions" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "inv_tx_ingredient_idx" ON "inventory_transactions" USING btree ("ingredient_id");--> statement-breakpoint
CREATE UNIQUE INDEX "kiosk_terminals_identifier_uk" ON "kiosk_terminals" USING btree ("identifier");--> statement-breakpoint
CREATE INDEX "kiosk_terminals_tenant_idx" ON "kiosk_terminals" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "kiosk_terminals_location_idx" ON "kiosk_terminals" USING btree ("location_id");--> statement-breakpoint
CREATE UNIQUE INDEX "location_holiday_location_date_uk" ON "location_holiday_hours" USING btree ("location_id","holiday_date");--> statement-breakpoint
CREATE INDEX "location_holiday_hours_location_idx" ON "location_holiday_hours" USING btree ("location_id");--> statement-breakpoint
CREATE UNIQUE INDEX "location_hours_location_day_uk" ON "location_hours" USING btree ("location_id","day_of_week");--> statement-breakpoint
CREATE INDEX "location_hours_location_idx" ON "location_hours" USING btree ("location_id");--> statement-breakpoint
CREATE UNIQUE INDEX "location_settings_location_uk" ON "location_settings" USING btree ("location_id");--> statement-breakpoint
CREATE UNIQUE INDEX "locations_tenant_slug_uk" ON "locations" USING btree ("tenant_id","slug");--> statement-breakpoint
CREATE UNIQUE INDEX "locations_tenant_code_uk" ON "locations" USING btree ("tenant_id","code");--> statement-breakpoint
CREATE INDEX "locations_tenant_idx" ON "locations" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "locations_brand_idx" ON "locations" USING btree ("brand_id");--> statement-breakpoint
CREATE INDEX "locations_status_idx" ON "locations" USING btree ("status");--> statement-breakpoint
CREATE UNIQUE INDEX "loyalty_config_tenant_uk" ON "loyalty_config" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "loyalty_ledger_tenant_idx" ON "loyalty_ledger" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "loyalty_ledger_customer_idx" ON "loyalty_ledger" USING btree ("customer_id");--> statement-breakpoint
CREATE INDEX "loyalty_ledger_order_idx" ON "loyalty_ledger" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "loyalty_ledger_expiry_idx" ON "loyalty_ledger" USING btree ("customer_id","expires_at");--> statement-breakpoint
CREATE INDEX "menu_categories_tenant_idx" ON "menu_categories" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "menu_categories_menu_idx" ON "menu_categories" USING btree ("menu_id");--> statement-breakpoint
CREATE INDEX "menu_categories_parent_idx" ON "menu_categories" USING btree ("parent_id");--> statement-breakpoint
CREATE UNIQUE INDEX "menu_item_ingredients_uk" ON "menu_item_ingredients" USING btree ("menu_item_id","ingredient_id");--> statement-breakpoint
CREATE INDEX "menu_item_ingredients_item_idx" ON "menu_item_ingredients" USING btree ("menu_item_id");--> statement-breakpoint
CREATE INDEX "menu_item_ingredients_ingredient_idx" ON "menu_item_ingredients" USING btree ("ingredient_id");--> statement-breakpoint
CREATE UNIQUE INDEX "milo_item_location_uk" ON "menu_item_location_overrides" USING btree ("menu_item_id","location_id");--> statement-breakpoint
CREATE INDEX "milo_item_idx" ON "menu_item_location_overrides" USING btree ("menu_item_id");--> statement-breakpoint
CREATE INDEX "milo_location_idx" ON "menu_item_location_overrides" USING btree ("location_id");--> statement-breakpoint
CREATE UNIQUE INDEX "mimgr_item_group_uk" ON "menu_item_modifier_groups" USING btree ("menu_item_id","modifier_group_id");--> statement-breakpoint
CREATE INDEX "mimgr_item_idx" ON "menu_item_modifier_groups" USING btree ("menu_item_id");--> statement-breakpoint
CREATE INDEX "mimgr_group_idx" ON "menu_item_modifier_groups" USING btree ("modifier_group_id");--> statement-breakpoint
CREATE UNIQUE INDEX "menu_items_tenant_sku_uk" ON "menu_items" USING btree ("tenant_id","sku");--> statement-breakpoint
CREATE UNIQUE INDEX "menu_items_tenant_slug_uk" ON "menu_items" USING btree ("tenant_id","slug");--> statement-breakpoint
CREATE INDEX "menu_items_tenant_idx" ON "menu_items" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "menu_items_category_idx" ON "menu_items" USING btree ("category_id");--> statement-breakpoint
CREATE INDEX "menu_items_tax_class_idx" ON "menu_items" USING btree ("tax_class_id");--> statement-breakpoint
CREATE INDEX "menu_items_active_idx" ON "menu_items" USING btree ("tenant_id","category_id");--> statement-breakpoint
CREATE UNIQUE INDEX "mla_menu_location_uk" ON "menu_location_assignments" USING btree ("menu_id","location_id");--> statement-breakpoint
CREATE INDEX "mla_menu_idx" ON "menu_location_assignments" USING btree ("menu_id");--> statement-breakpoint
CREATE INDEX "mla_location_idx" ON "menu_location_assignments" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "menus_tenant_idx" ON "menus" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "menus_brand_idx" ON "menus" USING btree ("brand_id");--> statement-breakpoint
CREATE INDEX "modifier_groups_tenant_idx" ON "modifier_groups" USING btree ("tenant_id");--> statement-breakpoint
CREATE UNIQUE INDEX "mlo_modifier_location_uk" ON "modifier_location_overrides" USING btree ("modifier_id","location_id");--> statement-breakpoint
CREATE INDEX "mlo_modifier_idx" ON "modifier_location_overrides" USING btree ("modifier_id");--> statement-breakpoint
CREATE INDEX "mlo_location_idx" ON "modifier_location_overrides" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "modifiers_tenant_idx" ON "modifiers" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "modifiers_group_idx" ON "modifiers" USING btree ("modifier_group_id");--> statement-breakpoint
CREATE INDEX "notification_templates_tenant_idx" ON "notification_templates" USING btree ("tenant_id");--> statement-breakpoint
CREATE UNIQUE INDEX "notification_templates_uk" ON "notification_templates" USING btree ("tenant_id","event_type","channel","language");--> statement-breakpoint
CREATE INDEX "notifications_tenant_idx" ON "notifications" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "notifications_order_idx" ON "notifications" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "notifications_customer_idx" ON "notifications" USING btree ("customer_id");--> statement-breakpoint
CREATE INDEX "notifications_status_idx" ON "notifications" USING btree ("status","scheduled_at");--> statement-breakpoint
CREATE INDEX "order_item_modifiers_item_idx" ON "online_order_item_modifiers" USING btree ("order_item_id");--> statement-breakpoint
CREATE INDEX "order_item_modifiers_modifier_idx" ON "online_order_item_modifiers" USING btree ("modifier_id");--> statement-breakpoint
CREATE INDEX "order_items_order_idx" ON "online_order_items" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "order_items_menu_item_idx" ON "online_order_items" USING btree ("menu_item_id");--> statement-breakpoint
CREATE INDEX "order_status_logs_order_idx" ON "online_order_status_logs" USING btree ("order_id");--> statement-breakpoint
CREATE UNIQUE INDEX "online_orders_number_uk" ON "online_orders" USING btree ("order_number");--> statement-breakpoint
CREATE INDEX "online_orders_tenant_idx" ON "online_orders" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "online_orders_location_idx" ON "online_orders" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "online_orders_customer_idx" ON "online_orders" USING btree ("customer_id");--> statement-breakpoint
CREATE INDEX "online_orders_delivery_zone_idx" ON "online_orders" USING btree ("delivery_zone_id");--> statement-breakpoint
CREATE INDEX "online_orders_discount_idx" ON "online_orders" USING btree ("discount_id");--> statement-breakpoint
CREATE INDEX "online_orders_status_created_idx" ON "online_orders" USING btree ("tenant_id","location_id","status","created_at");--> statement-breakpoint
CREATE INDEX "online_orders_scheduled_idx" ON "online_orders" USING btree ("tenant_id","scheduled_for");--> statement-breakpoint
CREATE UNIQUE INDEX "order_ratings_order_uk" ON "order_ratings" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "order_ratings_customer_idx" ON "order_ratings" USING btree ("customer_id");--> statement-breakpoint
CREATE INDEX "order_ratings_location_idx" ON "order_ratings" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "outbox_events_tenant_idx" ON "outbox_events" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "outbox_events_status_idx" ON "outbox_events" USING btree ("status","next_retry_at");--> statement-breakpoint
CREATE INDEX "outbox_events_aggregate_idx" ON "outbox_events" USING btree ("aggregate_type","aggregate_id");--> statement-breakpoint
CREATE UNIQUE INDEX "password_reset_tokens_hash_uk" ON "password_reset_tokens" USING btree ("token_hash");--> statement-breakpoint
CREATE INDEX "password_reset_tokens_user_idx" ON "password_reset_tokens" USING btree ("user_id");--> statement-breakpoint
CREATE UNIQUE INDEX "payments_gateway_payment_id_uk" ON "payments" USING btree ("gateway_payment_id");--> statement-breakpoint
CREATE INDEX "payments_tenant_idx" ON "payments" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "payments_order_idx" ON "payments" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "payments_customer_idx" ON "payments" USING btree ("customer_id");--> statement-breakpoint
CREATE INDEX "payments_location_idx" ON "payments" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "plan_change_logs_tenant_idx" ON "plan_change_logs" USING btree ("tenant_id");--> statement-breakpoint
CREATE UNIQUE INDEX "plans_slug_uk" ON "plans" USING btree ("slug");--> statement-breakpoint
CREATE UNIQUE INDEX "platform_sessions_refresh_hash_uk" ON "platform_sessions" USING btree ("refresh_token_hash");--> statement-breakpoint
CREATE INDEX "platform_sessions_platform_user_idx" ON "platform_sessions" USING btree ("platform_user_id");--> statement-breakpoint
CREATE INDEX "platform_sessions_expires_at_idx" ON "platform_sessions" USING btree ("expires_at");--> statement-breakpoint
CREATE UNIQUE INDEX "platform_users_email_uk" ON "platform_users" USING btree ("email");--> statement-breakpoint
CREATE INDEX "price_rules_tenant_idx" ON "price_rules" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "price_rules_location_idx" ON "price_rules" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "price_rules_menu_item_idx" ON "price_rules" USING btree ("menu_item_id");--> statement-breakpoint
CREATE INDEX "po_items_po_idx" ON "purchase_order_items" USING btree ("purchase_order_id");--> statement-breakpoint
CREATE INDEX "po_items_ingredient_idx" ON "purchase_order_items" USING btree ("ingredient_id");--> statement-breakpoint
CREATE UNIQUE INDEX "purchase_orders_number_uk" ON "purchase_orders" USING btree ("tenant_id","po_number");--> statement-breakpoint
CREATE INDEX "purchase_orders_tenant_idx" ON "purchase_orders" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "purchase_orders_supplier_idx" ON "purchase_orders" USING btree ("supplier_id");--> statement-breakpoint
CREATE UNIQUE INDEX "qr_codes_identifier_uk" ON "qr_codes" USING btree ("identifier");--> statement-breakpoint
CREATE UNIQUE INDEX "qr_codes_short_url_uk" ON "qr_codes" USING btree ("short_url");--> statement-breakpoint
CREATE INDEX "qr_codes_tenant_idx" ON "qr_codes" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "qr_codes_location_idx" ON "qr_codes" USING btree ("location_id");--> statement-breakpoint
CREATE UNIQUE INDEX "referral_programs_tenant_uk" ON "referral_programs" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "referrals_tenant_idx" ON "referrals" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "referrals_referrer_idx" ON "referrals" USING btree ("referrer_customer_id");--> statement-breakpoint
CREATE INDEX "referrals_code_idx" ON "referrals" USING btree ("referral_code");--> statement-breakpoint
CREATE INDEX "refunds_payment_idx" ON "refunds" USING btree ("payment_id");--> statement-breakpoint
CREATE INDEX "refunds_order_idx" ON "refunds" USING btree ("order_id");--> statement-breakpoint
CREATE UNIQUE INDEX "reservations_number_uk" ON "reservations" USING btree ("reservation_number");--> statement-breakpoint
CREATE INDEX "reservations_tenant_idx" ON "reservations" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "reservations_location_idx" ON "reservations" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "reservations_customer_idx" ON "reservations" USING btree ("customer_id");--> statement-breakpoint
CREATE INDEX "reservations_date_idx" ON "reservations" USING btree ("location_id","reservation_date");--> statement-breakpoint
CREATE INDEX "roles_tenant_idx" ON "roles" USING btree ("tenant_id");--> statement-breakpoint
CREATE UNIQUE INDEX "roles_tenant_name_uk" ON "roles" USING btree ("tenant_id","name");--> statement-breakpoint
CREATE INDEX "scheduled_slots_location_idx" ON "scheduled_order_slots" USING btree ("location_id");--> statement-breakpoint
CREATE UNIQUE INDEX "scheduled_slots_location_day_time_uk" ON "scheduled_order_slots" USING btree ("location_id","day_of_week","slot_time","order_type");--> statement-breakpoint
CREATE UNIQUE INDEX "srb_invoices_number_uk" ON "srb_invoices" USING btree ("srb_invoice_number");--> statement-breakpoint
CREATE INDEX "srb_invoices_tenant_idx" ON "srb_invoices" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "srb_invoices_order_idx" ON "srb_invoices" USING btree ("order_id");--> statement-breakpoint
CREATE UNIQUE INDEX "sub_invoices_number_uk" ON "subscription_invoices" USING btree ("invoice_number");--> statement-breakpoint
CREATE INDEX "sub_invoices_tenant_idx" ON "subscription_invoices" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "sub_invoices_subscription_idx" ON "subscription_invoices" USING btree ("subscription_id");--> statement-breakpoint
CREATE INDEX "subscriptions_tenant_idx" ON "subscriptions" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "subscriptions_plan_idx" ON "subscriptions" USING btree ("plan_id");--> statement-breakpoint
CREATE INDEX "subscriptions_status_idx" ON "subscriptions" USING btree ("status");--> statement-breakpoint
CREATE UNIQUE INDEX "subscriptions_gateway_ref_uk" ON "subscriptions" USING btree ("payment_gateway_ref");--> statement-breakpoint
CREATE INDEX "suppliers_tenant_idx" ON "suppliers" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "tax_classes_tenant_idx" ON "tax_classes" USING btree ("tenant_id");--> statement-breakpoint
CREATE UNIQUE INDEX "tax_classes_tenant_name_uk" ON "tax_classes" USING btree ("tenant_id","name");--> statement-breakpoint
CREATE UNIQUE INDEX "tax_invoices_number_uk" ON "tax_invoices" USING btree ("tenant_id","tax_authority","invoice_number");--> statement-breakpoint
CREATE INDEX "tax_invoices_tenant_idx" ON "tax_invoices" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "tax_invoices_order_idx" ON "tax_invoices" USING btree ("order_id");--> statement-breakpoint
CREATE UNIQUE INDEX "benchmarks_period_cuisine_city_uk" ON "tenant_benchmarks" USING btree ("period_month","cuisine_type","city","country_code");--> statement-breakpoint
CREATE UNIQUE INDEX "tenant_feature_usage_tenant_period_uk" ON "tenant_feature_usage" USING btree ("tenant_id","period_month");--> statement-breakpoint
CREATE INDEX "tenant_feature_usage_tenant_idx" ON "tenant_feature_usage" USING btree ("tenant_id");--> statement-breakpoint
CREATE UNIQUE INDEX "tenants_slug_uk" ON "tenants" USING btree ("slug");--> statement-breakpoint
CREATE UNIQUE INDEX "tenants_billing_email_uk" ON "tenants" USING btree ("billing_email");--> statement-breakpoint
CREATE INDEX "tenants_plan_idx" ON "tenants" USING btree ("plan_id");--> statement-breakpoint
CREATE INDEX "tenants_status_idx" ON "tenants" USING btree ("status");--> statement-breakpoint
CREATE INDEX "upsell_tenant_idx" ON "upsell_impressions" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "upsell_order_idx" ON "upsell_impressions" USING btree ("order_id");--> statement-breakpoint
CREATE UNIQUE INDEX "ula_user_role_location_uk" ON "user_location_access" USING btree ("user_id","role_id","location_id");--> statement-breakpoint
CREATE INDEX "ula_user_idx" ON "user_location_access" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "ula_role_idx" ON "user_location_access" USING btree ("role_id");--> statement-breakpoint
CREATE INDEX "ula_location_idx" ON "user_location_access" USING btree ("location_id");--> statement-breakpoint
CREATE UNIQUE INDEX "user_sessions_token_hash_uk" ON "user_sessions" USING btree ("token_hash");--> statement-breakpoint
CREATE INDEX "user_sessions_user_idx" ON "user_sessions" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "user_sessions_expires_at_idx" ON "user_sessions" USING btree ("expires_at");--> statement-breakpoint
CREATE UNIQUE INDEX "users_tenant_email_uk" ON "users" USING btree ("tenant_id","email");--> statement-breakpoint
CREATE INDEX "users_tenant_idx" ON "users" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "wallet_ledger_tenant_idx" ON "wallet_ledger" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "wallet_ledger_customer_idx" ON "wallet_ledger" USING btree ("customer_id");--> statement-breakpoint
CREATE INDEX "wallet_ledger_order_idx" ON "wallet_ledger" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "wa_sessions_tenant_idx" ON "whatsapp_sessions" USING btree ("tenant_id");--> statement-breakpoint
CREATE INDEX "wa_sessions_location_idx" ON "whatsapp_sessions" USING btree ("location_id");--> statement-breakpoint
CREATE INDEX "wa_sessions_customer_idx" ON "whatsapp_sessions" USING btree ("customer_id");