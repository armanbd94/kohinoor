<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('productions', function (Blueprint $table) {
            $table->id();
            $table->string('batch_no')->unique();
            $table->unsignedBigInteger('warehouse_id');
            $table->foreign('warehouse_id')->references('id')->on('warehouses');
            $table->date('start_date');
            $table->date('end_date')->nullable();
            $table->unsignedBigInteger('product_id');
            $table->foreign('product_id')->references('id')->on('products');
            $table->date('mfg_date');
            $table->date('exp_date');
            $table->enum('production_status',['1','2','3','4'])->default('1')->comment = "1=Pending, 2=Processing,3=Packaging,4=Finished";
            $table->enum('material_delivered_status',['1','2','3'])->default('1')->comment = "1=Pending, 2=Delivered,3=Partially Delivered";
            $table->enum('material_received_status',['1','2','3'])->default('1')->comment = "1=Pending, 2=Received,3=Partially Received";
            $table->text('description')->nullable();
            $table->enum('status',['1','2'])->default('1')->comment = "1=Active, 2=Inactive";
            $table->string('created_by')->nullable();
            $table->string('modified_by')->nullable();
            $table->string('material_delivered_by')->nullable();
            $table->dateTime('material_delivered_datetime')->nullable();
            $table->string('material_received_by')->nullable();
            $table->dateTime('material_received_datetime')->nullable();
            $table->enum('material_returned',['1','2'])->default('2')->comment = "1=Yes, 2=No";
            $table->string('material_returned_by')->nullable();
            $table->dateTime('material_returned_datetime')->nullable();
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
        Schema::dropIfExists('productions');
    }
}
