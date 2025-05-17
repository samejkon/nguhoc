<?php

namespace App\Http\Controllers\BackEnd;

use App\Http\Controllers\Controller;

class CouponController extends Controller
{
    public function index()
    {
        return view('admin.coupon.index');
    }
}
