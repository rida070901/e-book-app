<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\BookController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// ----------- api endpoints --------------

Route::group(['namespace' => 'Api'], function () {


    Route::post('/login', 'UserController@createUser');
    Route::group(['middleware' => ['auth:sanctum']], function () { //sanctum package wants user to be logged in to be able to access the stuff below
        Route::any('/bookList', 'BookController@bookList');
        Route::any('/recommendedBookList', 'BookController@recommendedBookList');
        Route::any('/newBooksList', 'BookController@newBooksList');
        Route::any('/fromCheapestList', 'BookController@fromCheapestList');
        Route::any('/searchBookList', 'BookController@searchBookList');
        Route::any('/bookDetail', 'BookController@bookDetail');
        Route::any('/checkout', 'PayController@checkout');
        Route::any('/trailerDetail', 'BookController@trailerDetail');
        Route::any('/chapterList', 'ChapterController@chapterList');
        Route::any('/chapterDetail', 'ChapterController@chapterDetail');
        Route::any('/booksBought', 'BookController@booksBought'); // to show list of bought books by user
        Route::any('/bookBought', 'BookController@bookBought'); // to check if one book is bought or not by user
        Route::any('/orderList', 'BookController@orderList');
        Route::any('/bookAuthor', 'BookController@bookAuthor'); // author profile page
        Route::any('/bookListAuthor', 'BookController@bookListAuthor'); // all books written by this author
        Route::any('/favoritesList', 'FavoriteController@favoritesList');
        Route::any('/addFavorite', 'FavoriteController@addFavorite');
        Route::any('/updateFavorite', 'FavoriteController@updateFavorite');
        Route::any('/checkFavorite', 'FavoriteController@checkFavorite');
    });
    Route::any('/web_go_hooks', 'PayController@web_go_hooks');

});
