@extends('admin.layouts.client')

@section('title', 'Mã giảm giá')

@section('content')
    <div class="panel-header bg-primary-gradient">
        <div class="page-inner py-5">
            <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row">
                <div>
                    <h2 class="text-white pb-2 fw-bold">Mã giảm giá</h2>
                </div>
            </div>
        </div>
    </div>
    <div class="page-inner mt--5">
        <div class="row mt--2">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex align-items-center">
                            <h4 class="card-title">Danh sách</h4>
                            <button class="btn btn-primary btn-round ml-auto" data-toggle="modal"
                                data-target="#createCoupon">
                                <i class="fa fa-plus"></i>
                                &nbsp;Thêm Mã Giảm Giá
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="card-body">
                            @include('admin.coupon.create')
                            @include('admin.coupon.edit')
                            <div class="table-responsive">
                                <table id="add-row" class="display table table-hover">
                                    <thead>
                                        <tr>
                                            <th width="10%">Mã</th>
                                            <th width="13%">Ngày bắt đầu</th>
                                            <th width="13%">Ngày kết thúc</th>
                                            <th>Số vé</th>
                                            <th width="11%">Số đơn đã áp dụng</th>
                                            <th width="12%">Số tiền giảm</th>
                                            <th width="10%">Trạng thái</th>
                                            <th width="10%">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>Mã</th>
                                            <th>Ngày bắt đầu</th>
                                            <th>Ngày kết thúc</th>
                                            <th>Số vé</th>
                                            <th>Số đơn đã áp dụng</th>
                                            <th>Số tiền giảm</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        @if (count($coupons) > 0)
                                            @foreach ($coupons as $item)
                                                <tr class="{{ $item->is_active == 1 ? '' : 'table-danger' }}">
                                                    <td>{{ $item->code }}</td>
                                                    <td>{{ $item->start_date->format('d/m/Y') }}</td>
                                                    <td>{{ $item->end_date->format('d/m/Y') }}</td>
                                                    <td>{{ $item->usage_limit }}</td>
                                                    <td>{{ $item->used_count }}</td>
                                                    <td>{{ $item->discount }}</td>
                                                    <td>
                                                        @if ($item->is_active == 1)
                                                            <span class="badge badge-success">Hoạt động</span>
                                                        @else
                                                            <span class="badge badge-danger">Khóa</span>
                                                        @endif
                                                    </td>
                                                    <td>
                                                        @if ($item->is_active == 1)
                                                            <button class="btn btn-sm btn-warning editBtn"
                                                                data-id="{{ $item->id }}"
                                                                data-code="{{ $item->code }}"
                                                                data-discount="{{ $item->discount }}"
                                                                data-start_date="{{ $item->start_date->format('Y-m-d') }}"
                                                                data-end_date="{{ $item->end_date->format('Y-m-d') }}"
                                                                data-min_order_amount="{{ $item->min_order_amount }}"
                                                                data-usage_limit="{{ $item->usage_limit }}"
                                                                data-user_limit="{{ $item->user_limit }}"
                                                                data-url="{{ route('coupon.update', $item->id) }}"
                                                                data-toggle="modal" data-target="#editModal">
                                                                Sửa
                                                            </button>
                                                        @endif
                                                    </td>
                                                </tr>
                                            @endforeach

                                        @endif
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            $('#editModal').on('show.bs.modal', function(event) {
                const button = $(event.relatedTarget); // dùng jQuery vì đang dùng Bootstrap 4
                const modal = $(this);

                // Gán giá trị vào các input
                modal.find('#edit-code').val(button.data('code'));
                modal.find('#edit-discount').val(button.data('discount'));
                modal.find('#edit-start_date').val(button.data('start_date'));
                modal.find('#edit-end_date').val(button.data('end_date'));
                modal.find('#edit-min_order_amount').val(button.data('min_order_amount'));
                modal.find('#edit-usage_limit').val(button.data('usage_limit'));
                modal.find('#edit-user_limit').val(button.data('user_limit'));

                // Gán action cho form
                modal.find('#editForm').attr('action', button.data('url'));
            });
        });
    </script>
@endsection
