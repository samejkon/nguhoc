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
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class TaiKhoanController extends Controller
{
    //
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
    public function __construct(
        protected User $model // dependency injection(tiem model user vao de dung)
    ) {
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
    public function dangnhap()
    {
        if (Auth::check()) {
            if (Auth::user()->roles == 2) {
                return redirect()->route('tongquan');
            }
            return redirect()->route('taikhoan');
        }

        return view('user.dangnhap');
    }
    public function taikhoan()
    {
        if (!auth()->check()) {
            return redirect()->route('dangnhap');
        }
        $userId = auth()->user()->id_users;

        // Lấy danh sách phiếu xuất của user hiện tại
        $danhSachPhieuXuat = (new \App\Models\PhieuXuat)->layDanhSachPhieuXuatTheoBoLoc([['id_users', '=', $userId]]);
        $danhSachChiTietPhieuXuat = (new \App\Models\ChiTietPhieuXuat)->layDanhSachChiTietPhieuXuat();
        $danhSachSanPham = (new \App\Models\SanPham)->layDanhSachSanPham();
        $danhSachMaGiamGia = (new \App\Models\MaGiamGia)->layDanhSachMaGiamGia();
        $danhSachThuVienHinh = (new \App\Models\ThuVienHinh)->layDanhSachThuVienHinh();

        return view('user.taikhoan', compact(
            'danhSachPhieuXuat',
            'danhSachChiTietPhieuXuat',
            'danhSachSanPham',
            'danhSachMaGiamGia',
            'danhSachThuVienHinh'
        ));
    }
    public function dangxuat()
    {
        if (Auth::check()) {
            Auth::logout();
        }
        return back();
    }
    public function xulytaikhoan(Request $request)
    {
        $request->validate(['thaoTac' => 'required|string']);
        if ($request->thaoTac == "đổi thông tin") { // *******************************************************************************************doi thong tin giao hang
            $rules = [
                'email' => 'required|email|max:150|min:5|exists:users,email',
                'hoTen' => 'required|string|max:50|min:3',
                'soDienThoai' => 'required|numeric|digits:10',
                'diaChi' => 'required|string|max:255|min:3'
            ];
            $messages = [
                'required' => ':attribute bắt buộc nhập',
                'string' => ':attribute đã nhập sai',
                'min' => ':attribute tối thiểu :min ký tự',
                'max' => ':attribute tối đa :max ký tự',
                'exists' => ':attribute không tồn tại',
                'digits' => ':attribute không đúng :digits ký tự',
                'email' => ':attribute không đúng định dạng email'
            ];
            $attributes = [
                'email' => 'Email',
                'hoTen' => 'Họ tên',
                'soDienThoai' => 'Số điện thoại',
                'diaChi' => 'Địa chỉ'
            ];
            $request->validate($rules, $messages, $attributes);
            $thongTinNguoiDung = $this->nguoiDung->timNguoiDungTheoSoDienThoai($request->soDienThoai); //tim so dien thoai da ton tai hay chua
            if (!empty($thongTinNguoiDung) && $thongTinNguoiDung->email != $request->email) {
                return back()->with('loidoithongtin', 'Số điện thoại đã tồn tại.')->with('thongbao', 'Đổi thông tin thất bại.');
            }
            if (Auth::check()) {
                if ($request->email == Auth::user()->email) { //email dung voi tai khoan tren database
                    $dataNguoiDung = [
                        $request->hoTen,
                        $request->soDienThoai,
                        $request->diaChi,
                        Auth::user()->roles, //loainguoidung 0 là khách hàng, 1 là đối tác, 2 là nhân viên
                        Auth::user()->email,
                        Auth::user()->password
                    ];
                    $this->nguoiDung->suaNguoiDung($dataNguoiDung, Auth::user()->id_users); //sua lai thong tin nguoi dung
                    return back()->with('thongbao', 'Đổi thông tin thành công.');
                }
                return back()->with('loidoithongtin', 'Email không chính xác.')->with('thongbao', 'Đổi thông tin thất bại.');
            }
            return back()->with('loidoithongtin', 'Thông tin đăng nhập không hợp lệ.')->with('thongbao', 'Đổi thông tin thất bại.');
        }
        if ($request->thaoTac == "đổi mật khẩu") { // *******************************************************************************************doi mat khau
            $rules = [
                'email' => 'required|email|max:150|min:5|exists:users,email',
                'matKhauCu' => 'required|string|max:32|min:8',
                'matKhauMoi' => 'required|string|max:32|min:8',
                'nhapLaiMatKhauMoi' => 'required|string|max:32|min:8|same:matKhauMoi'
            ];
            $messages = [
                'required' => ':attribute bắt buộc nhập',
                'string' => ':attribute đã nhập sai',
                'min' => ':attribute tối thiểu :min ký tự',
                'max' => ':attribute tối đa :max ký tự',
                'exists' => ':attribute không tồn tại',
                'email' => ':attribute không đúng định dạng email',
                'same' => ':attribute không khớp với mật khẩu'
            ];
            $attributes = [
                'email' => 'Email',
                'matKhauCu' => 'Mật khẩu cũ',
                'matKhauMoi' => 'Mật khẩu mới',
                'nhapLaiMatKhauMoi' => 'Nhập lại mật khẩu mới'
            ];
            $request->validate($rules, $messages, $attributes);
            if ($request->matKhauCu == $request->matKhauMoi) {
                return back()->with('loidoimatkhau', 'Mật khẩu cũ và mật khẩu mới trùng nhau.')->with('thongbao', 'Đổi mật khẩu thất bại.');
            }
            if (Auth::check()) {
                if ($request->email == Auth::user()->email && Hash::check($request->matKhauCu, Auth::user()->password)) { //email va mat khau cu dung voi tai khoan tren database
                    $dataNguoiDung = [
                        Auth::user()->name_users,
                        Auth::user()->phone,
                        Auth::user()->address,
                        Auth::user()->roles, //loainguoidung 0 là khách hàng, 1 là đối tác, 2 là nhân viên
                        Auth::user()->email,
                        bcrypt($request->matKhauMoi)
                    ];
                    $this->nguoiDung->suaNguoiDung($dataNguoiDung, Auth::user()->id_users); //sua lai thong tin nguoi dung
                    return back()->with('thongbao', 'Đổi mật khẩu thành công.');
                }
                return back()->with('loidoimatkhau', 'Mật khẩu cũ không chính xác.')->with('thongbao', 'Đổi mật khẩu thất bại.');
            }
            return back()->with('loidoimatkhau', 'Thông tin đăng nhập không hợp lệ.')->with('thongbao', 'Đổi mật khẩu thất bại.');
        }
        if ($request->thaoTac == "đăng nhập") { // *******************************************************************************************dang nhap
            $rules = [
                'email' => 'required|email|max:150|min:5|exists:users,email',
                'matKhau' => 'required|string|max:32|min:8'
            ];
            $messages = [
                'required' => ':attribute bắt buộc nhập',
                'string' => ':attribute đã nhập sai',
                'min' => ':attribute tối thiểu :min ký tự',
                'max' => ':attribute tối đa :max ký tự',
                'exists' => ':attribute không tồn tại',
                'email' => ':attribute không đúng định dạng email',
            ];
            $attributes = [
                'email' => 'Email',
                'matKhau' => 'Mật khẩu'
            ];
            $request->validate($rules, $messages, $attributes);
            $dataNguoiDung = [
                'email' => $request->email,
                'password' => $request->matKhau
            ];
            if (Auth::attempt($dataNguoiDung)) {
                /** @var \App\Models\User|\Illuminate\Contracts\Auth\MustVerifyEmail $user */
                $user = Auth::user();
                if (! $user->hasVerifiedEmail()) {
                    return redirect()->route('verification.notice');
                }
                if (Auth::user()->status == 0) { //neu tai khoan dang bi khoa
                    Auth::logout();
                    return back()->with('loidangnhap', 'Tài khoản hiện đang bị khóa.');
                }
                if (Auth::user()->roles == 2) { //neu tai khoan la nhan vien
                    return redirect()->route('tongquan')->with('hoTenNhanVien', Auth::user()->name_users);
                }
                return redirect()->back();
            }
            return back()->with('loidangnhap', 'Thông tin đăng nhập không hợp lệ.');
        }
        if ($request->thaoTac == "đăng ký") {  // *******************************************************************************************dang ky
            $rules = [
                'emailDangKy' => 'required|email|max:150|min:5|unique:users,email',
                'matKhauDangKy' => 'required|string|max:32|min:8',
                'nhapLaiMatKhauDangKy' => 'required|string|max:32|min:8|same:matKhauDangKy',
                'hoTen' => 'required|string|max:50|min:3',
                'soDienThoai' => 'required|numeric|digits:10',
                'diaChi' => 'required|string|max:255|min:3'
            ];
            $messages = [
                'required' => ':attribute bắt buộc nhập',
                'string' => ':attribute đã nhập sai',
                'numeric' => ':attribute đã nhập sai',
                'min' => ':attribute tối thiểu :min ký tự',
                'max' => ':attribute tối đa :max ký tự',
                'digits' => ':attribute không đúng :digits ký tự',
                'unique' => ':attribute đã tồn tại',
                'email' => ':attribute không đúng định dạng email',
                'same' => ':attribute không khớp với mật khẩu'
            ];
            $attributes = [
                'emailDangKy' => 'Email',
                'matKhauDangKy' => 'Mật khẩu',
                'nhapLaiMatKhauDangKy' => 'Nhập lại mật khẩu',
                'hoTen' => 'Họ tên',
                'soDienThoai' => 'Số điện thoại',
                'diaChi' => 'Địa chỉ'
            ];

            $data = $request->validate($rules, $messages, $attributes);
            // $user['updated_at'] = Carbon::now();
            //pass request roi khong can check nua
            $data = [
                'email' => $request->emailDangKy,
                'password' => Hash::make($request->matKhauDangKy),
                'name_users' => $request->hoTen,
                'phone' => $request->soDienThoai,
                'address' => $request->diaChi
            ];

            $user = $this->model->create($data);
            event(new Registered($user));
            Auth::login($user);
            return redirect()->route('verification.notice');
        }
        return redirect()->route('/')->with('thongbao', 'Thao tác thất bại vui lòng thử lại!');
    }
}
