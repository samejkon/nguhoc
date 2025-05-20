<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Models\SanPham;
use App\Models\ThuVienHinh;
use App\Models\Laptop;
use App\Models\PhuKien;
use App\Models\HangSanXuat;
use App\Models\QuaTang;
use App\Models\NguoiDung;
use App\Models\PhieuXuat;
use App\Models\ChiTietPhieuXuat;
use App\Models\MaGiamGia;
use App\Models\LoiPhanHoi;
use App\Models\Contact; // Thêm dòng này
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;

class TrangChuController extends Controller
{
    private $sanPham;
    private $laptop;
    private $phuKien;
    private $thuVienHinh;
    private $hangSanXuat;
    private $quaTang;
    private $nguoiDung;
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
        $this->phieuXuat = new PhieuXuat();
        $this->chiTietPhieuXuat = new ChiTietPhieuXuat();
        $this->maGiamGia = new MaGiamGia();
        $this->loiPhanHoi = new LoiPhanHoi();
    }
    public function trangchu()
    {
        $danhSachSanPham = $this->sanPham->layDanhSachSanPham();
        $danhSachSanPhamMoiRaMat = $this->sanPham->layDanhSachSanPhamTheoBoLoc([], NULL, 'moinhat');
        $danhSachSanPhamBanChay = $this->sanPham->layDanhSachSanPhamTheoBoLoc([], NULL, 'banchaynhat');
        $danhSachSanPhamUuDai = $this->sanPham->layDanhSachSanPhamTheoBoLoc([], NULL, 'uudainhat');
        $danhSachThuVienHinh = $this->thuVienHinh->layDanhSachThuVienHinh();
        $danhSachHangSanXuat = $this->hangSanXuat->layDanhSachHangSanXuat();
        $danhSachLaptop = $this->laptop->layDanhSachLaptop();
        $danhSachSanPhamLaLaptop = [];
        $danhSachSanPhamLaPhuKien = [];
        $danhSachLaptopSinhVien = [];
        $danhSachLaptopDoHoa = [];
        $danhSachLaptopGaming = [];
        foreach ($danhSachSanPham as $sanpham) {
            if ($sanpham->cat_products == 1) { // la phu kien
                $danhSachSanPhamLaPhuKien = array_merge($danhSachSanPhamLaPhuKien, [$sanpham]);
            }
            if ($sanpham->cat_products == 0) { // la laptop
                $danhSachSanPhamLaLaptop = array_merge($danhSachSanPhamLaLaptop, [$sanpham]);
                $thongTinLaptop = $this->laptop->timLaptopTheoMa($sanpham->id_laptop);
                if ($thongTinLaptop->demand == 'Sinh Viên') { // la laptop nhu cau la sinh vien
                    $danhSachLaptopSinhVien = array_merge($danhSachLaptopSinhVien, [$sanpham]);
                } elseif ($thongTinLaptop->demand == 'Đồ Họa') { // la laptop nhu cau la do hoa
                    $danhSachLaptopDoHoa = array_merge($danhSachLaptopDoHoa, [$sanpham]);
                } elseif ($thongTinLaptop->demand == 'Gaming') { // la laptop nhu cau la gaming
                    $danhSachLaptopGaming = array_merge($danhSachLaptopGaming, [$sanpham]);
                }
            }
        }
        return view('user.trangchu', compact(
            'danhSachSanPham',
            'danhSachSanPhamMoiRaMat',
            'danhSachSanPhamBanChay',
            'danhSachSanPhamUuDai',
            'danhSachThuVienHinh',
            'danhSachHangSanXuat',
            'danhSachLaptop',
            'danhSachLaptopSinhVien',
            'danhSachLaptopDoHoa',
            'danhSachLaptopGaming',
            'danhSachSanPhamLaLaptop',
            'danhSachSanPhamLaPhuKien'
        ));
    }
    public function giohang()
    {
        if (empty(session('gioHang'))) return redirect()->route('/')->with('thongbao', 'Giỏ hàng chưa có sản phẩm!');
        $danhSachHangSanXuat = $this->hangSanXuat->layDanhSachHangSanXuat();
        return view('user.giohang', compact(
            'danhSachHangSanXuat'
        ));
    }
    public function yeuthich()
    {
        if (empty(session('yeuThich'))) return redirect()->route('/')->with('thongbao', 'Danh sách yêu thích chưa có sản phẩm!');
        $danhSachHangSanXuat = $this->hangSanXuat->layDanhSachHangSanXuat();
        return view('user.yeuthich', compact(
            'danhSachHangSanXuat',

        ));
    }
    public function baohanh()
    {
        $danhSachHangSanXuat = $this->hangSanXuat->layDanhSachHangSanXuat();
        return view('user.baohanh', compact(
            'danhSachHangSanXuat'
        ));
    }
    public function tragop(Request $request)
    {
        session()->flush();
        return back();
    }
    public function lienhe()
    {
        $danhSachHangSanXuat = $this->hangSanXuat->layDanhSachHangSanXuat();
        return view('user.lienhe', compact(
            'danhSachHangSanXuat'
        ));
    }
    public function xulylienhe(Request $request)
    {
        if ($request->thaoTac == "gửi lời nhắn") {
            // Nếu chưa đăng nhập, validate đầy đủ thông tin
            if (!auth()->check()) {
                $rules = [
                    'hoTen' => 'required|string|max:50|min:3',
                    'soDienThoai' => 'required|numeric|digits:10',
                    'diaChi' => 'required|string|max:255|min:3',
                    'noiDung' => 'required|string|max:255|min:3',
                    'email' => 'required|email|max:255'
                ];
                $messages = [
                    'required' => ':attribute bắt buộc nhập',
                    'string' => ':attribute đã nhập sai',
                    'numeric' => ':attribute đã nhập sai',
                    'min' => ':attribute tối thiểu :min ký tự',
                    'max' => ':attribute tối đa :max ký tự',
                    'digits' => ':attribute không đúng :digits ký tự',
                    'email' => ':attribute không đúng định dạng'
                ];
                $attributes = [
                    'hoTen' => 'Họ tên',
                    'soDienThoai' => 'Số điện thoại',
                    'diaChi' => 'Địa chỉ',
                    'noiDung' => 'Nội dung',
                    'email' => 'Email'
                ];
                $request->validate($rules, $messages, $attributes);

                // Tìm user theo SĐT
                $thongTinNguoiDung = $this->nguoiDung->timNguoiDungTheoSoDienThoai($request->soDienThoai);
                if (!empty($thongTinNguoiDung)) {
                    if ($thongTinNguoiDung->status == 0) {
                        return back()->with('thongbao', 'Thông tin người dùng hiện đang bị tạm khóa do hủy quá nhiều đơn!');
                    }
                    // Cập nhật lại thông tin user nếu cần
                    $dataNguoiDung = [
                        $request->hoTen,
                        $thongTinNguoiDung->phone,
                        $request->diaChi,
                        $thongTinNguoiDung->roles,
                        $request->email,
                        $thongTinNguoiDung->password
                    ];
                    $this->nguoiDung->suaNguoiDung($dataNguoiDung, $thongTinNguoiDung->id_users);
                    $idNguoiDung = $thongTinNguoiDung->id_users;
                } else {
                    // Tạo user mới
                    $ngayTao = now();
                    $dataNguoiDung = [
                        NULL,
                        $request->hoTen,
                        $request->soDienThoai,
                        $request->diaChi,
                        1,
                        0,
                        $request->email,
                        Hash::make(Str::random(8)),
                        $ngayTao
                    ];
                    $this->nguoiDung->themNguoiDung($dataNguoiDung);
                    $thongTinNguoiDung = $this->nguoiDung->timNguoiDungTheoNgayTao($ngayTao);
                    $idNguoiDung = is_array($thongTinNguoiDung) ? $thongTinNguoiDung['id_users'] : $thongTinNguoiDung->id_users;
                }
            } else {
                // Nếu đã đăng nhập, lấy user_id từ user hiện tại
                $idNguoiDung = auth()->user()->id_users;
                // Nếu muốn cho phép cập nhật lại thông tin user, có thể bổ sung code ở đây
            }

            // Lưu liên hệ vào bảng contacts
            Contact::create([
                'content' => $request->noiDung,
                'status' => 0,
                'user_id' => $idNguoiDung,
            ]);
            return redirect()->route('/')->with('thongbao', 'Gửi lời nhắn thành công, sẽ có nhân viên liên hệ bạn sớm nhất có thể!');
        }
        return redirect()->route('/')->with('thongbao', 'Thao tác thất bại vui lòng thử lại!');
    }
}
