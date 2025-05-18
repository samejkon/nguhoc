<?php

namespace App\Http\Controllers\BackEnd;

use App\Http\Controllers\Controller;
use App\Models\SanPham;
use App\Models\ThuVienHinh;
use App\Models\Laptop;
use App\Models\PhuKien;
use App\Models\HangSanXuat;
use App\Models\QuaTang;
use App\Models\NguoiDung;
use App\Models\PhieuNhap;
use App\Models\ChiTietPhieuNhap;
use App\Models\PhieuXuat;
use App\Models\ChiTietPhieuXuat;
use App\Models\MaGiamGia;
use App\Models\LoiPhanHoi;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Auth;
use PDF;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class XulyTongquan extends Controller
{
    //
    private $sanPham;
    private $laptop;
    private $phuKien;
    private $thuVienHinh;
    private $hangSanXuat;
    private $quaTang;
    private $nguoiDung;
    private $phieuNhap;
    private $chiTietPhieuNhap;
    private $phieuXuat;
    private $chiTietPhieuXuat;
    private $maGiamGia;
    private $loiPhanHoi;

    public function __construct()
    {
        $this->sanPham = new SanPham();
        $this->laptop = new Laptop();
        $this->phuKien = new PhuKien();
        $this->thuVienHinh = new ThuVienHinh();
        $this->hangSanXuat = new HangSanXuat();
        $this->quaTang = new QuaTang();
        $this->nguoiDung = new NguoiDung();
        $this->phieuNhap = new PhieuNhap();
        $this->chiTietPhieuNhap = new ChiTietPhieuNhap();
        $this->phieuXuat = new PhieuXuat();
        $this->chiTietPhieuXuat = new ChiTietPhieuXuat();
        $this->maGiamGia = new MaGiamGia();
        $this->loiPhanHoi = new LoiPhanHoi();
    }
    public function tongquan(Request $request)
    {
        if (!Auth::check() || Auth::user()->roles != 2) {
            return redirect()->route('login');
        }

        // Thống kê khách hàng
        $tongKhachHang = $this->nguoiDung->count();
        $khachMoiHomNay = $this->nguoiDung->whereDate('date_created', now()->toDateString())->count();
        $khachMoiTuan = $this->nguoiDung->whereBetween('date_created', [now()->startOfWeek(), now()->endOfWeek()])->count();
        $khachMoiThang = $this->nguoiDung->whereMonth('date_created', now()->month)->count();
        $topKhachHang = DB::table('invoice')
            ->select('id_users', DB::raw('COUNT(*) as so_don'), DB::raw('SUM(total_money) as tong_tien'))
            ->groupBy('id_users')
            ->orderByDesc('tong_tien')
            ->limit(5)
            ->get();

        // Thống kê sản phẩm
        $tongSanPham = $this->sanPham->count();
        $sanPhamSapHet = $this->sanPham->where('qty', '<', 10)->get();
        $topSanPhamBanChay = \DB::table('invoice_details')
            ->select('id_products', \DB::raw('SUM(qty) as so_luong'))
            ->groupBy('id_products')
            ->orderByDesc('so_luong')
            ->limit(5)
            ->get();

        $sanPhamItBan = \DB::table('invoice_details')
            ->select('id_products', \DB::raw('SUM(qty) as so_luong'))
            ->groupBy('id_products')
            ->orderBy('so_luong')
            ->limit(5)
            ->get();

        // Thống kê đơn hàng
        $tongDonHang = $this->phieuXuat->count();
        $donChoXacNhan = $this->phieuXuat->where('delivery_status', 1)->count();
        $donDangGiao = $this->phieuXuat->where('delivery_status', 3)->count();
        $donHoanThanh = $this->phieuXuat->where('delivery_status', 4)->count();
        $donHuy = $this->phieuXuat->where('delivery_status', 0)->count();
        $doanhThuHomNay = $this->phieuXuat->whereDate('date_created', now()->toDateString())->sum('total_money');
        $doanhThuThang = $this->phieuXuat->whereMonth('date_created', now()->month)->sum('total_money');
        $doanhThuTong = $this->phieuXuat->sum('total_money');
        $donMoiNgay = $this->phieuXuat->whereDate('date_created', now()->toDateString())->count();
        $donMoiTuan = $this->phieuXuat->whereBetween('date_created', [now()->startOfWeek(), now()->endOfWeek()])->count();
        $donMoiThang = $this->phieuXuat->whereMonth('date_created', now()->month)->count();
        $tyLeHoanThanh = $tongDonHang > 0 ? round($donHoanThanh / $tongDonHang * 100, 2) : 0;

        // Dữ liệu biểu đồ (ví dụ: doanh thu 7 ngày gần nhất)
        $doanhThu7Ngay = [];
        for ($i = 6; $i >= 0; $i--) {
            $ngay = now()->subDays($i)->toDateString();
            $doanhThu7Ngay[] = [
                'ngay' => $ngay,
                'doanhthu' => $this->phieuXuat->whereDate('date_created', $ngay)->sum('total_money')
            ];
        }
        // Đơn hàng 7 ngày gần nhất
        $donHang7Ngay = [];
        for ($i = 6; $i >= 0; $i--) {
            $ngay = now()->subDays($i)->toDateString();
            $donHang7Ngay[] = [
                'ngay' => $ngay,
                'so_luong' => $this->phieuXuat->whereDate('date_created', $ngay)->count()
            ];
        }
        // Tỷ lệ đơn hàng theo trạng thái
        $trangThaiDon = [
            'Chờ xác nhận' => $donChoXacNhan,
            'Đang giao' => $donDangGiao,
            'Hoàn thành' => $donHoanThanh,
            'Đã huỷ' => $donHuy
        ];

        // ...giữ lại các biến cũ nếu cần...

        return view('admin.tongquan', compact(
            'tongKhachHang',
            'khachMoiHomNay',
            'khachMoiTuan',
            'khachMoiThang',
            'topKhachHang',
            'tongSanPham',
            'sanPhamSapHet',
            'topSanPhamBanChay',
            'sanPhamItBan',
            'tongDonHang',
            'donChoXacNhan',
            'donDangGiao',
            'donHoanThanh',
            'donHuy',
            'doanhThuHomNay',
            'doanhThuThang',
            'doanhThuTong',
            'donMoiNgay',
            'donMoiTuan',
            'donMoiThang',
            'tyLeHoanThanh',
            'doanhThu7Ngay',
            'donHang7Ngay',
            'trangThaiDon'
            // ...các biến khác...
        ));
    }
}
