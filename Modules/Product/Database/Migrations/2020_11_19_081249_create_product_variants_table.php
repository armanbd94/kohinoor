<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductVariantsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('product_variants', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('product_id')->nullable();
            $table->foreign('product_id')->references('id')->on('products');
            $table->string('item_name')->unique();
            $table->string('item_code')->unique();
            $table->double('item_cost')->nullable();
            $table->unsignedBigInteger('item_base_unit_id')->nullable();
            $table->foreign('item_base_unit_id')->references('id')->on('units');
            $table->unsignedBigInteger('item_unit_id')->nullable();
            $table->foreign('item_unit_id')->references('id')->on('units');
            $table->string('item_base_unit_mrp')->nullable()->comment('Base Unit wise MRP');
            $table->string('item_base_unit_price')->nullable()->comment('Base Unit wise Price');
            $table->string('item_unit_mrp')->nullable()->comment('Base Unit wise MRP');
            $table->string('item_unit_price')->nullable()->comment('Base Unit wise Price');
            $table->double('item_base_unit_qty')->nullable();
            $table->double('item_unit_qty')->nullable();
            $table->double('alert_qty')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('product_variants');
    }
}
