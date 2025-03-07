<?php

use App\Admin\Controllers\ChapterController;
use Illuminate\Routing\Router;

Admin::routes();

Route::group([
    'prefix'        => config('admin.route.prefix'),
    'namespace'     => config('admin.route.namespace'),
    'middleware'    => config('admin.route.middleware'),
    'as'            => config('admin.route.prefix') . '.',
], function (Router $router) {

    $router->get('/', 'HomeController@index')->name('home');
    $router->resource('/users', UserController::class);
    $router->resource('/book-types', BookTypeController::class);
    $router->resource('/books', BookController::class);
    $router->resource('/orders', OrderController::class);
    $router->resource('/chapters', ChapterController::class);
    $router->resource('/favorites', FavoriteController::class);
});
