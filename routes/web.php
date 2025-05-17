<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;
use App\Http\Controllers\FrontEnd\GioHangController;
use App\Http\Controllers\FrontEnd\SanPhamController;
use App\Http\Controllers\FrontEnd\TaiKhoanController;
use App\Http\Controllers\FrontEnd\ThanhToanController;
use App\Http\Controllers\FrontEnd\TrangChuController;
use App\Http\Controllers\BackEnd\AdminController;
use App\Http\Controllers\BackEnd\CouponController;
use App\Http\Controllers\BackEnd\XulyHangsanxuat;
use App\Http\Controllers\BackEnd\XulyLaptop;
use App\Http\Controllers\BackEnd\XulyMagiamgia;
use App\Http\Controllers\BackEnd\XulyPhieuxuat;
use App\Http\Controllers\BackEnd\XulyPhieunhap;
use App\Http\Controllers\BackEnd\XulyNguoidung;
use App\Http\Controllers\BackEnd\XulyPhukien;
use App\Http\Controllers\BackEnd\XulySanpham;
use App\Http\Controllers\BackEnd\XulyTongquan;

// Route::get('/', function () {
//     return view('welcome');
// });

// FrontEnd
Route::group(['namespace' => 'FrontEnd'], function () {
    // trang chu
    Route::get('/', [TrangChuController::class, 'trangchu'])->name('/');
    Route::get('/tragop', [TrangChuController::class, 'tragop'])->name('tragop');
    Route::get('/baohanh', [TrangChuController::class, 'baohanh'])->name('baohanh');
    Route::get('/lienhe', [TrangChuController::class, 'lienhe'])->name('lienhe');
    Route::post('/xulylienhe', [TrangChuController::class, 'xulylienhe'])->name('xulylienhe');
    // sanpham
    Route::get('chitietsp', [SanPhamController::class, 'chitietsp'])->name('chitietsp');
    Route::get('danhsachsp', [SanPhamController::class, 'danhsachsp'])->name('danhsachsp');
    Route::get('timkiem', [SanPhamController::class, 'timkiem'])->name('timkiem');
    // yeu thich
    Route::middleware(['auth', 'verified'])->group(function () {
        Route::get('taikhoan', [TaiKhoanController::class, 'taikhoan'])->name('taikhoan');
        Route::get('giohang', [TrangChuController::class, 'giohang'])->name('giohang');
        Route::get('yeuthich', [TrangChuController::class, 'yeuthich'])->name('yeuthich');
        Route::get('thanhtoan', [ThanhToanController::class, 'thanhtoan'])->name('thanhtoan');

        Route::post('xulygiohang', [GioHangController::class, 'xulygiohang'])->name('xulygiohang');
        Route::post('xulythanhtoan', [ThanhToanController::class, 'xulythanhtoan'])->name('xulythanhtoan');
    });

    Route::get('yeuthich', [TrangChuController::class, 'yeuthich'])->name('yeuthich');
    // gio hang
    Route::post('xulygiohang', [GioHangController::class, 'xulygiohang'])->name('xulygiohang');
    // tai khoan
    Route::middleware('guest')->group(function () {
        Route::get('dangnhap', [TaiKhoanController::class, 'dangnhap'])->name('login');
        Route::post('xulytaikhoan', [TaiKhoanController::class, 'xulytaikhoan'])->name('xulytaikhoan');
    });
    Route::get('dangxuat', [TaiKhoanController::class, 'dangxuat'])->middleware('auth')->name('dangxuat');
    // thanh toan
    Route::post('xulythanhtoan', [ThanhToanController::class, 'xulythanhtoan'])->name('xulythanhtoan');
});
//
Route::get('/clear', function () {
    Artisan::call('cache:clear');
    return back();
});
Route::get('/thongtinthanhtoan', function () {
    $thongTinThanhToanVNPAY = [
        'nganHang' => 'NCB',
        'soThe' => '9704198526191432198',
        'ngayPhatHanh' => '07/15',
        'tenChuThe' => 'NGUYEN VAN A',
        'matKhauOTP' => '123456'
    ];
    return dd($thongTinThanhToanVNPAY);
});


//admin
Route::namespace('BackEnd')->get('/tongquan', [XulyTongquan::class, 'tongquan'])->name('tongquan');
Route::namespace('BackEnd')->post('/xulysanpham', [XulySanpham::class, 'xulysanpham'])->name('xulysanpham');

Route::namespace('BackEnd')->get('/laptop', [AdminController::class, 'laptop'])->name('laptop');
Route::namespace('BackEnd')->post('/xulylaptop', [XulyLaptop::class, 'xulylaptop'])->name('xulylaptop');

Route::namespace('BackEnd')->get('/phukien', [AdminController::class, 'phukien'])->name('phukien');
Route::namespace('BackEnd')->post('/xulyphukien', [XulyPhukien::class, 'xulyphukien'])->name('xulyphukien');

Route::namespace('BackEnd')->get('/hangsanxuat', [AdminController::class, 'hangsanxuat'])->name('hangsanxuat');
Route::namespace('BackEnd')->post('/xulyhangsanxuat', [XulyHangsanxuat::class, 'xulyhangsanxuat'])->name('xulyhangsanxuat');

Route::namespace('BackEnd')->get('/phieuxuat', [AdminController::class, 'phieuxuat'])->name('phieuxuat');
//Route::get('/inphieuxuat', [AdminController::class, 'inphieuxuat'])->name('inphieuxuat');
Route::namespace('BackEnd')->get('/xemphieuxuat', [AdminController::class, 'xemphieuxuat'])->name('xemphieuxuat');

Route::namespace('BackEnd')->post('/xulyphieuxuat', [XulyPhieuxuat::class, 'xulyphieuxuat'])->name('xulyphieuxuat');
//Route::post('/xulyphieuxuat', [AdminController::class, 'xulyphieuxuat'])->name('xulyphieuxuat');

Route::namespace('BackEnd')->get('/themphieuxuat', [AdminController::class, 'themphieuxuat'])->name('themphieuxuat');
//Route::get('/themphieuxuat', [AdminController::class, 'themphieuxuat'])->name('themphieuxuat');
Route::namespace('BackEnd')->get('/suaphieuxuat', [AdminController::class, 'suaphieuxuat'])->name('suaphieuxuat');
//Route::get('/suaphieuxuat', [AdminController::class, 'suaphieuxuat'])->name('suaphieuxuat');

Route::namespace('BackEnd')->get('/magiamgia', [AdminController::class, 'magiamgia'])->name('magiamgia');
Route::namespace('BackEnd')->post('/xulymagiamgia', [XulyMagiamgia::class, 'xulymagiamgia'])->name('xulymagiamgia');

//Mã giảm giá
Route::resource('/coupon', CouponController::class);


Route::namespace('BackEnd')->get('/nguoidung', [AdminController::class, 'nguoidung'])->name('nguoidung');
Route::namespace('BackEnd')->post('/xulynguoidung', [XulyNguoidung::class, 'xulynguoidung'])->name('xulynguoidung');

//Route::get('/phieunhap', [AdminController::class, 'phieunhap'])->name('phieunhap');
Route::namespace('BackEnd')->get('/phieunhap', [AdminController::class, 'phieunhap'])->name('phieunhap');
//Route::get('/inphieunhap', [AdminController::class, 'inphieunhap'])->name('inphieunhap');

Route::namespace('BackEnd')->post('/xulyphieunhap', [XulyPhieunhap::class, 'xulyphieunhap'])->name('xulyphieunhap');
//Route::post('/xulyphieunhap', [AdminController::class, 'xulyphieunhap'])->name('xulyphieunhap');

Route::namespace('BackEnd')->get('/themphieunhap', [AdminController::class, 'themphieunhap'])->name('themphieunhap');
//Route::get('/themphieunhap', [AdminController::class, 'themphieunhap'])->name('themphieunhap');
Route::namespace('BackEnd')->get('/suaphieunhap', [AdminController::class, 'suaphieunhap'])->name('suaphieunhap');
//Route::get('/suaphieunhap', [AdminController::class, 'suaphieunhap'])->name('suaphieunhap');


Route::get('/clear', function () {
    Artisan::call('cache:clear');
    return back();
});

use Illuminate\Foundation\Auth\EmailVerificationRequest;

Route::get('/email/verify', function () {
    return view('auth.verify-email');
})->middleware('auth')->name('verification.notice');

Route::get('/email/verify/{id}/{hash}', function (EmailVerificationRequest $request) {
    $request->fulfill();
    return redirect('')->intended('/');
})->middleware(['auth', 'signed'])->name('verification.verify');

Route::post('/email/verification-notification', function (Illuminate\Http\Request $request) {
    $request->user()->sendEmailVerificationNotification();
    return back()->with('message', 'Verification link sent!');
})->middleware(['auth', 'throttle:6,1'])->name('verification.send');
