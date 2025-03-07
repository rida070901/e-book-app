<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\BookController;

Route::group(['namespace'=>'Author'], function(){
    Route::any('/login', 'AuthorController@login');
});