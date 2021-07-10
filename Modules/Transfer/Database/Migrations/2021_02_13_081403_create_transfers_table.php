<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTransfersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transfers', function (Blueprint $table) {
            $table->id();
            $table->string('chalan_no')->unique();
            $table->unsignedBigInteger('from_warehouse_id');
            $table->foreign('from_warehouse_id')->references('id')->on('warehouses');
            $table->unsignedBigInteger('to_warehouse_id');
            $table->foreign('to_warehouse_id')->references('id')->on('warehouses');
            $table->float('item');
            $table->float('total_qty');
            $table->float('total_tax');
            $table->double('total_cost');
            $table->double('total_labor_cost');
            $table->double('shipping_cost')->nullable();
            $table->double('grand_total');
            $table->string('document')->nullable();
            $table->text('note')->nullable();
            $table->date('transfer_date');
            $table->enum('transfer_status',['1','2','3'])->comment="1=Completed,2=Pending,3=Sent";
            $table->string('carried_by')->nullable();
            $table->unsignedBigInteger('received_by');
            $table->foreign('received_by')->references('id')->on('asms');
            $table->string('created_by')->nullable();
            $table->string('modified_by')->nullable();
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
        Schema::dropIfExists('transfers');
    }
}
