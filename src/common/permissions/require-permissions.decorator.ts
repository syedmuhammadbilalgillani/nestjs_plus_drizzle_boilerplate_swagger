import { SetMetadata } from '@nestjs/common';
import type { PermissionKey } from './permissions';

export const PERMISSIONS_KEY = 'required-permissions';

/**
 * Decorator: attach one or more required permission keys to a route
 * (or controller). The `PermissionsGuard` reads this metadata via
 * `Reflector` and denies the request if the authenticated user is
 * missing any of the listed permissions.
 *
 * Default behaviour is AND — all listed permissions must be granted.
 * If you need an OR-of-N check, compose it in the service layer.
 *
 * Usage:
 *   @UseGuards(JwtAuthGuard, PermissionsGuard)
 *   @RequirePermissions(PERMISSIONS.USERS_DELETE)
 *   @Delete(':id')
 *   remove() {}
 */
export const RequirePermissions = (...permissions: PermissionKey[]) =>
  SetMetadata(PERMISSIONS_KEY, permissions);
