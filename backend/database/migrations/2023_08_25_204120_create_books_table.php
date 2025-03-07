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
        Schema::create('books', function (Blueprint $table) {
            $table->id();
            $table->string('user_token', 50);
            $table->string('name', 50);
            $table->string('thumbnail', 150); //book cover
            $table->json('media', 150)->nullable();
            $table->text('description',)->nullable();
            $table->smallInteger('type_id');
            $table->float('price');
            $table->smallInteger('page_num')->nullable();
            $table->string('language', 20)->nullable();
            $table->date('first_published_date')->nullable();
            $table->smallInteger('follow')->nullable();
            $table->float('score')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('books');
    }
};
