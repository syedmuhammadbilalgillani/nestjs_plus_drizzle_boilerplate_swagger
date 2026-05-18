import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import {
  hasAllPermissions,
  type PermissionKey,
  type PermissionsMap,
} from './permissions';
import { PERMISSIONS_KEY } from './require-permissions.decorator';

/**
 * Route-level permission enforcement.
 *
 * Pre-conditions:
 *   - `JwtAuthGuard` must run BEFORE this guard so `req.user` is set.
 *     Typical usage: `@UseGuards(JwtAuthGuard, PermissionsGuard)`.
 *
 * Behaviour:
 *   - If the route (or its controller) is NOT decorated with
 *     `@RequirePermissions(...)`, this guard is a no-op (allow).
 *     This keeps existing un-decorated routes working unchanged
 *     while we migrate handlers over.
 *   - If the user object isn't on the request, deny with 403. (The
 *     auth guard should have already thrown 401 in that case; this
 *     is defensive.)
 *   - SUPER_ADMIN is always allowed — handled inside `hasPermission`.
 */
@Injectable()
export class PermissionsGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const required = this.reflector.getAllAndOverride<
      PermissionKey[] | undefined
    >(PERMISSIONS_KEY, [context.getHandler(), context.getClass()]);

    // No metadata = route not gated by permissions.
    if (!required || required.length === 0) return true;

    const req = context.switchToHttp().getRequest<{
      user?: {
        id?: string;
        role?: string;
        permissions?: PermissionsMap | null;
      };
    }>();
    const user = req.user;
    if (!user || !user.role) {
      throw new ForbiddenException('Authentication required');
    }

    const ok = hasAllPermissions(
      { role: user.role, permissions: user.permissions },
      required,
    );
    if (!ok) {
      // Don't leak the user's permission map; just say what was needed.
      throw new ForbiddenException(
        `Missing permission${required.length > 1 ? 's' : ''}: ${required.join(', ')}`,
      );
    }
    return true;
  }
}
