<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('coupons', function (Blueprint $table) {
            $table->id();
            $table->string('code')->unique();                     // Mã giảm giá
            $table->decimal('value', 10, 2);                      // Giá trị giảm cố định (VD: 50.000đ)
            $table->decimal('min_order_amount', 10, 2)->nullable(); // Giá trị đơn hàng tối thiểu

            $table->unsignedInteger('usage_limit')->nullable();   // Tổng số lượt dùng toàn hệ thống
            $table->unsignedInteger('user_limit')->nullable();    // Số lượt dùng mỗi user
            $table->unsignedInteger('used_count')->default(0);    // Tổng số lượt đã dùng

            $table->timestamp('start_date');                      // Ngày bắt đầu áp dụng (không nullable)
            $table->timestamp('end_date');                        // Ngày kết thúc (không nullable)

            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('coupons');
    }
};
