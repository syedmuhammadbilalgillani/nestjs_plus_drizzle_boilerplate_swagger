/**
 * Permission catalog — single source of truth.
 *
 * Format: `<module>.<action>` flat string keys. Stored on
 * `users.permissions` as `{ "users.create": true, ... }` (jsonb).
 *
 * Rules of the system:
 *   • SUPER_ADMIN bypasses every check — never denied. We don't even
 *     read the column for them.
 *   • Any permission present and `=== true` grants access. Anything
 *     else (missing, `false`, `null`) denies.
 *   • The admin app keeps an IDENTICAL catalog at admin/lib/permissions.ts
 *     so the picker UI and route guards reference the same strings.
 *
 * When adding a new permission:
 *   1. Add it here.
 *   2. Add it to admin/lib/permissions.ts.
 *   3. Decorate the controller route(s) with @RequirePermissions(...).
 *   4. Wrap the corresponding admin UI with <Can permission="...">.
 */

export const PERMISSIONS = {
  // ── Dashboard ─────────────────────────────────────────────────
  DASHBOARD_READ: 'dashboard.read',

  // ── Staff users ───────────────────────────────────────────────
  USERS_READ: 'users.read',
  USERS_CREATE: 'users.create',
  USERS_UPDATE: 'users.update',
  USERS_DELETE: 'users.delete',
  USERS_MANAGE_PERMISSIONS: 'users.manage-permissions',

  // ── Categories ────────────────────────────────────────────────
  CATEGORIES_READ: 'categories.read',
  CATEGORIES_CREATE: 'categories.create',
  CATEGORIES_UPDATE: 'categories.update',
  CATEGORIES_DELETE: 'categories.delete',

  // ── Menu items (incl. variants + addons) ──────────────────────
  MENU_READ: 'menu.read',
  MENU_CREATE: 'menu.create',
  MENU_UPDATE: 'menu.update',
  MENU_DELETE: 'menu.delete',

  // ── Discounts ─────────────────────────────────────────────────
  DISCOUNTS_READ: 'discounts.read',
  DISCOUNTS_CREATE: 'discounts.create',
  DISCOUNTS_UPDATE: 'discounts.update',
  DISCOUNTS_DELETE: 'discounts.delete',

  // ── Customers ────────────────────────────────────────────────
  CUSTOMERS_READ: 'customers.read',
  CUSTOMERS_CREATE: 'customers.create',
  CUSTOMERS_UPDATE: 'customers.update',
  CUSTOMERS_DELETE: 'customers.delete',

  // ── Orders ───────────────────────────────────────────────────
  ORDERS_READ: 'orders.read',
  ORDERS_CREATE: 'orders.create',
  ORDERS_UPDATE_STATUS: 'orders.update-status',
  ORDERS_UPDATE_PAYMENT: 'orders.update-payment',
  ORDERS_ASSIGN_RIDER: 'orders.assign-rider',
  ORDERS_CANCEL: 'orders.cancel',
  ORDERS_REFUND: 'orders.refund',

  // ── KDS (kitchen display) ────────────────────────────────────
  KDS_READ: 'kds.read',
  KDS_UPDATE_STATUS: 'kds.update-status',
  KDS_ASSIGN_RIDER: 'kds.assign-rider',

  // ── POS ──────────────────────────────────────────────────────
  POS_OPERATE: 'pos.operate',
  POS_APPLY_DISCOUNT: 'pos.apply-discount',
  POS_VOID_LINE: 'pos.void-line',

  // ── Delivery zones & locations ───────────────────────────────
  DELIVERY_ZONES_READ: 'delivery.zones.read',
  DELIVERY_ZONES_CREATE: 'delivery.zones.create',
  DELIVERY_ZONES_UPDATE: 'delivery.zones.update',
  DELIVERY_ZONES_DELETE: 'delivery.zones.delete',
  // ── Riders ───────────────────────────────────────────────────
  DELIVERY_RIDERS_READ: 'delivery.riders.read',
  DELIVERY_RIDERS_CREATE: 'delivery.riders.create',
  DELIVERY_RIDERS_UPDATE: 'delivery.riders.update',
  DELIVERY_RIDERS_DELETE: 'delivery.riders.delete',

  // ── Database (export / import) ───────────────────────────────
  // SUPER_ADMIN-only in practice; defining the keys keeps the
  // catalog complete and lets us tighten the guard later if we
  // open this to ADMIN users.
  DB_EXPORT: 'db.export',
  DB_IMPORT: 'db.import',
} as const;

/** Union of every permission string in the catalog. */
export type PermissionKey = (typeof PERMISSIONS)[keyof typeof PERMISSIONS];

/** Flat list — useful for the admin picker UI. */
export const ALL_PERMISSIONS = Object.values(PERMISSIONS) as PermissionKey[];

/**
 * Permission groups for the admin permissions UI. Each group label
 * matches a sidebar module so non-technical admins can scan it.
 */
export const PERMISSION_GROUPS: Record<string, PermissionKey[]> = {
  Dashboard: [PERMISSIONS.DASHBOARD_READ],
  Users: [
    PERMISSIONS.USERS_READ,
    PERMISSIONS.USERS_CREATE,
    PERMISSIONS.USERS_UPDATE,
    PERMISSIONS.USERS_DELETE,
    PERMISSIONS.USERS_MANAGE_PERMISSIONS,
  ],
  Categories: [
    PERMISSIONS.CATEGORIES_READ,
    PERMISSIONS.CATEGORIES_CREATE,
    PERMISSIONS.CATEGORIES_UPDATE,
    PERMISSIONS.CATEGORIES_DELETE,
  ],
  Menu: [
    PERMISSIONS.MENU_READ,
    PERMISSIONS.MENU_CREATE,
    PERMISSIONS.MENU_UPDATE,
    PERMISSIONS.MENU_DELETE,
  ],
  Discounts: [
    PERMISSIONS.DISCOUNTS_READ,
    PERMISSIONS.DISCOUNTS_CREATE,
    PERMISSIONS.DISCOUNTS_UPDATE,
    PERMISSIONS.DISCOUNTS_DELETE,
  ],
  Customers: [
    PERMISSIONS.CUSTOMERS_READ,
    PERMISSIONS.CUSTOMERS_CREATE,
    PERMISSIONS.CUSTOMERS_UPDATE,
    PERMISSIONS.CUSTOMERS_DELETE,
  ],
  Orders: [
    PERMISSIONS.ORDERS_READ,
    PERMISSIONS.ORDERS_CREATE,
    PERMISSIONS.ORDERS_UPDATE_STATUS,
    PERMISSIONS.ORDERS_UPDATE_PAYMENT,
    PERMISSIONS.ORDERS_ASSIGN_RIDER,
    PERMISSIONS.ORDERS_CANCEL,
    PERMISSIONS.ORDERS_REFUND,
  ],
  KDS: [
    PERMISSIONS.KDS_READ,
    PERMISSIONS.KDS_UPDATE_STATUS,
    PERMISSIONS.KDS_ASSIGN_RIDER,
  ],
  POS: [
    PERMISSIONS.POS_OPERATE,
    PERMISSIONS.POS_APPLY_DISCOUNT,
    PERMISSIONS.POS_VOID_LINE,
  ],
  Delivery: [
    PERMISSIONS.DELIVERY_ZONES_READ,
    PERMISSIONS.DELIVERY_ZONES_CREATE,
    PERMISSIONS.DELIVERY_ZONES_UPDATE,
    PERMISSIONS.DELIVERY_ZONES_DELETE,
    PERMISSIONS.DELIVERY_RIDERS_READ,
    PERMISSIONS.DELIVERY_RIDERS_CREATE,
    PERMISSIONS.DELIVERY_RIDERS_UPDATE,
    PERMISSIONS.DELIVERY_RIDERS_DELETE,
  ],
  Database: [PERMISSIONS.DB_EXPORT, PERMISSIONS.DB_IMPORT],
};

/**
 * Shape of the `users.permissions` jsonb column. A value is granted
 * iff the key is present AND strictly `true`.
 */
export type PermissionsMap = Partial<Record<PermissionKey, boolean>>;

/**
 * Centralised check. Use this everywhere instead of poking at the map
 * directly so behaviour (SUPER_ADMIN bypass, role-default fallbacks)
 * stays in one place.
 */
export function hasPermission(
  user: { role: string; permissions?: PermissionsMap | null } | null | undefined,
  key: PermissionKey,
): boolean {
  if (!user) return false;
  if (user.role === 'SUPER_ADMIN') return true;
  return user.permissions?.[key] === true;
}

/** True iff the user is granted ALL of the listed permissions. */
export function hasAllPermissions(
  user: { role: string; permissions?: PermissionsMap | null } | null | undefined,
  keys: PermissionKey[],
): boolean {
  return keys.every((k) => hasPermission(user, k));
}

/** True iff the user is granted ANY of the listed permissions. */
export function hasAnyPermission(
  user: { role: string; permissions?: PermissionsMap | null } | null | undefined,
  keys: PermissionKey[],
): boolean {
  return keys.some((k) => hasPermission(user, k));
}
