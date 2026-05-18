export interface PaginationMeta {
  total: number;
  page: number;
  limit: number;
  totalPages: number;
}

export class ApiResponse<T> {
  data!: T;
  meta?: PaginationMeta;

  static ok<T>(data: T, meta?: PaginationMeta): ApiResponse<T> {
    const res = new ApiResponse<T>();
    res.data = data;
    res.meta = meta;
    return res;
  }

  static paginated<T>(
    data: T,
    total: number,
    page: number,
    limit: number,
  ): ApiResponse<T> {
    return ApiResponse.ok(data, {
      total,
      page,
      limit,
      totalPages: Math.ceil(total / limit),
    });
  }
}
