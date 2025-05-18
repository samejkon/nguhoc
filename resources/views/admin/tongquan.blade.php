@extends('admin.layouts.client')
@section('title')
    Tổng quan
@endsection
@section('head')
    {{-- thêm css --}}
    <style>
        .avatar-online::before {
            background-color: #EB3E32 !important;
            top: 0 !important;
        }

        .noidung-chuadoc {
            font-weight: 700 !important;
        }

        .tieude-chuadoc {
            font-weight: 900 !important;
        }

        .bg-daxem {
            background-color: #aaa !important;
        }
    </style>
@endsection
@section('content')
    <div class="panel-header bg-primary-gradient">
        <div class="page-inner py-5">
            <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row">
                <div>
                    <h2 class="text-white pb-2 fw-bold">Tổng Quan</h2>
                </div>
            </div>
        </div>
    </div>
    <div class="page-inner mt--5">
        <div class="row mt--2">
            <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-warning card-round">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-5">
                                <div class="icon-big text-center">
                                    <i class="fas fa-laptop"></i>
                                </div>
                            </div>
                            <div class="col-7 col-stats">
                                <div class="numbers">
                                    <p class="card-category">Điện Thoại</p>
                                    <h4 class="card-title">{{ !empty($soLuongLaptop) ? $soLuongLaptop : '0' }}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-danger card-round">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-5">
                                <div class="icon-big text-center">
                                    <i class="fas fa-keyboard"></i>
                                </div>
                            </div>
                            <div class="col-7 col-stats">
                                <div class="numbers">
                                    <p class="card-category">Phụ Kiện</p>
                                    <h4 class="card-title">{{ !empty($soLuongPhuKien) ? $soLuongPhuKien : '0' }}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-success card-round">
                    <div class="card-body ">
                        <div class="row">
                            <div class="col-5">
                                <div class="icon-big text-center">
                                    <i class="fas fa-file-invoice-dollar"></i>
                                </div>
                            </div>
                            <div class="col-7 col-stats">
                                <div class="numbers">
                                    <p class="card-category">Đơn Hàng</p>
                                    <h4 class="card-title">{{ !empty($soLuongDonHang) ? $soLuongDonHang : '0' }}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-secondary card-round">
                    <div class="card-body ">
                        <div class="row">
                            <div class="col-5">
                                <div class="icon-big text-center">
                                    <i class="fas fa-user"></i>
                                </div>
                            </div>
                            <div class="col-7 col-stats">
                                <div class="numbers">
                                    <p class="card-category">Người Dùng</p>
                                    <h4 class="card-title">{{ !empty($soLuongNguoiDung) ? $soLuongNguoiDung : '0' }}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Thống kê khách hàng -->
        <div class="row">
            <div class="col-md-3">
                <div class="card card-stats card-primary card-round shadow">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-4"><i class="fas fa-users fa-2x text-primary"></i></div>
                            <div class="col-8">
                                <div class="numbers">
                                    <p class="card-category">Tổng khách hàng</p>
                                    <h4 class="card-title">{{ $tongKhachHang }}</h4>
                                    <small>Hôm nay: {{ $khachMoiHomNay }} | Tuần: {{ $khachMoiTuan }} | Tháng:
                                        {{ $khachMoiThang }}</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Thống kê sản phẩm -->
            <div class="col-md-3">
                <div class="card card-stats card-info card-round shadow">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-4"><i class="fas fa-boxes fa-2x text-info"></i></div>
                            <div class="col-8">
                                <div class="numbers">
                                    <p class="card-category">Tổng sản phẩm</p>
                                    <h4 class="card-title">{{ $tongSanPham }}</h4>
                                    <small>Sắp hết: {{ count($sanPhamSapHet ?? []) }}</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Thống kê đơn hàng -->
            <div class="col-md-3">
                <div class="card card-stats card-success card-round shadow">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-4"><i class="fas fa-file-invoice-dollar fa-2x text-success"></i></div>
                            <div class="col-8">
                                <div class="numbers">
                                    <p class="card-category">Tổng đơn hàng</p>
                                    <h4 class="card-title">{{ $tongDonHang }}</h4>
                                    <small>Hôm nay: {{ $donMoiNgay }} | Tuần: {{ $donMoiTuan }} | Tháng:
                                        {{ $donMoiThang }}</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Thống kê doanh thu -->
            <div class="col-md-3">
                <div class="card card-stats card-warning card-round shadow">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-4"><i class="fas fa-coins fa-2x text-warning"></i></div>
                            <div class="col-8">
                                <div class="numbers">
                                    <p class="card-category">Doanh thu</p>
                                    <h4 class="card-title">{{ number_format($doanhThuTong) }}đ</h4>
                                    <small>Hôm nay: {{ number_format($doanhThuHomNay) }}đ | Tháng:
                                        {{ number_format($doanhThuThang) }}đ</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            {{-- <div class="col-md-4">
                <div class="card">
                    <div class="card-body pb-0">
                        <div class="h1 fw-bold float-right text-success">+7%</div>
                        <h2 class="mb-2">213</h2>
                        <p class="text-muted">Đơn đặt hàng hôm nay</p>
                        <div class="pull-in sparkline-fix">
                            <div id="lineChart"></div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body pb-0">
                        <div class="h1 fw-bold float-right text-danger">-3%</div>
                        <h2 class="mb-2">128</h2>
                        <p class="text-muted">Người dùng đăng ký hôm nay</p>
                        <div class="pull-in sparkline-fix">
                            <div id="lineChart1"></div>
                        </div>
                    </div>
                </div>
            </div> --}}
        </div>
        <div class="row" id="loiphanhoi">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <div class="card-head-row" style="height:2.65rem">
                            <div class="card-title">Doanh thu tuần này</div>
                        </div>
                    </div>
                    <div class="card-body" style="height: 21.25rem;">
                        <div class="chart-container">
                            <canvas id="barChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <div class="card-head-row" style="height:2.65rem">
                            <div class="card-title">Lời nhắn liên hệ</div>
                            <div class="card-tools">
                                <ul class="nav nav-pills nav-primary nav-pills-no-bd nav-sm">
                                    <li class="nav-item submenu">
                                        <a class="nav-link {{ isset($danhSachLoiPhanHoiChuaDoc) && count($danhSachLoiPhanHoiChuaDoc ?? []) > 0 ? 'active show' : '' }}"
                                            href="{{ url('tongquan?thaotac=doitrangthaitatca') }}"><i
                                                class="fa fa-check"></i>&nbsp;&nbsp;&nbsp;Đã đọc tất cả</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="card-body" style="height: 21.25rem;overflow: auto">
                        @if (!empty($danhSachLoiPhanHoi))
                            @foreach ($danhSachLoiPhanHoi as $loiPhanHoi)
                                {!! $loiPhanHoi->status == 0
                                    ? '<a href="' .
                                        url('tongquan?thaotac=doitrangthai&id_feedback=' . $loiPhanHoi->id_feedback) .
                                        '" class="donglienhe" style="color: #4d585f; background-color:#fff!important">'
                                    : '' !!}
                                <div class="d-flex">
                                    @if ($loiPhanHoi->status == 0)
                                        <div class="avatar avatar-online">
                                            <span class="avatar-title rounded-circle border border-white bg-primary"><i
                                                    class="fas fa-envelope"></i></span>
                                        </div>
                                        <div class="flex-1 candeu ml-3 pt-1 pr-3">
                                            <h6 class="text-uppercase fw-bold mb-1 tieude-chuadoc">
                                                {{ $loiPhanHoi->name_users }} - {{ $loiPhanHoi->phone }}
                                            </h6>
                                            <span class="text-muted noidung-chuadoc">{{ $loiPhanHoi->content }}</span>
                                        </div>
                                    @else
                                        <div class="avatar">
                                            <span class="avatar-title rounded-circle border border-white bg-daxem"><i
                                                    class="fas fa-envelope"></i></span>
                                        </div>
                                        <div class="flex-1 candeu ml-3 pt-1 pr-3">
                                            <h6 class="text-uppercase fw-bold mb-1">{{ $loiPhanHoi->name_users }} -
                                                {{ $loiPhanHoi->phone }}
                                            </h6>
                                            <span class="text-muted">{{ $loiPhanHoi->content }}</span>
                                        </div>
                                    @endif
                                    <div class="float-right pt-1">
                                        <small class="text-muted">Lúc
                                            {{ date('H:i d/m/Y', strtotime($loiPhanHoi->date_created)) }}</small>
                                        {!! $loiPhanHoi->status == 1
                                            ? '<small class="text-muted cangiua"><a class="text-muted viethoachudau" href="' .
                                                url('tongquan?thaotac=doitrangthai&id_feedback=' . $loiPhanHoi->id_feedback) .
                                                '" style="text-transform: none !important;display:block">Đánh dấu chưa đọc</a></small>'
                                            : '' !!}
                                    </div>
                                </div>
                                <div class="separator-dashed"></div>
                                {!! $loiPhanHoi->status == 0 ? '</a>' : '' !!}
                            @endforeach
                        @endif
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4">
            <!-- Biểu đồ đường doanh thu -->
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header"><b>Doanh thu 7 ngày gần nhất</b></div>
                    <div class="card-body">
                        <canvas id="doanhThuLineChart"></canvas>
                    </div>
                </div>
            </div>
            <!-- Biểu đồ cột số lượng đơn hàng -->
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header"><b>Đơn hàng 7 ngày gần nhất</b></div>
                    <div class="card-body">
                        <canvas id="donHangBarChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4">
            <!-- Biểu đồ tròn tỷ lệ đơn hàng -->
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header"><b>Tỷ lệ đơn hàng theo trạng thái</b></div>
                    <div class="card-body">
                        <canvas id="trangThaiPieChart"></canvas>
                    </div>
                </div>
            </div>
            <!-- Top 5 sản phẩm bán chạy -->
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header"><b>Top 5 sản phẩm bán chạy</b></div>
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Sản phẩm</th>
                                    <th>Số lượng bán</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($topSanPhamBanChay as $i => $sp)
                                    <tr>
                                        <td>{{ $i + 1 }}</td>
                                        <td>{{ $sp->id_products }}</td>
                                        <td>{{ $sp->so_luong }}</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
@section('js')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Biểu đồ đường doanh thu
        var doanhThuData = {!! json_encode($doanhThu7Ngay) !!};
        var doanhThuLine = new Chart(document.getElementById('doanhThuLineChart'), {
            type: 'line',
            data: {
                labels: doanhThuData.map(e => e.ngay),
                datasets: [{
                    label: 'Doanh thu',
                    data: doanhThuData.map(e => e.doanhthu),
                    borderColor: 'rgb(23, 125, 255)',
                    backgroundColor: 'rgba(23, 125, 255, 0.2)',
                    fill: true,
                }]
            }
        });

        // Biểu đồ cột số lượng đơn hàng
        var donHangData = {!! json_encode($donHang7Ngay) !!};
        var donHangBar = new Chart(document.getElementById('donHangBarChart'), {
            type: 'bar',
            data: {
                labels: donHangData.map(e => e.ngay),
                datasets: [{
                    label: 'Đơn hàng',
                    data: donHangData.map(e => e.so_luong),
                    backgroundColor: 'rgb(255, 193, 7)'
                }]
            }
        });

        // Biểu đồ tròn tỷ lệ đơn hàng
        var trangThaiData = {!! json_encode($trangThaiDon) !!};
        var pie = new Chart(document.getElementById('trangThaiPieChart'), {
            type: 'pie',
            data: {
                labels: Object.keys(trangThaiData),
                datasets: [{
                    data: Object.values(trangThaiData),
                    backgroundColor: ['#007bff', '#ffc107', '#28a745', '#dc3545']
                }]
            }
        });
    </script>
@endsection
