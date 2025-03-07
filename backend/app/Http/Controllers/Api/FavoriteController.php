<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Book;
use App\Models\Favorite;
use App\Models\BookType;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;
//use Illuminate\Database\Eloquent\Model;

class FavoriteController extends Controller
{
    

    public function favoritesList(Request $request){ 
        $user = $request->user(); //from middleware
        try {
            $result = Favorite::join('books', 'favorites.book_id', '=', 'books.id')
            ->select('books.id', 'books.name', 'books.page_num', 'books.thumbnail', 'books.price', 'books.type_id')
            ->where('favorites.status', '=', '1')
            ->where('favorites.user_token', '=', $user->token)
            ->get();
        
            return response()->json([
                'code' => 200,
                'msg' => 'My favorite books are here',
                'data' => $result
            ], 200);
        } catch (\Throwable $throw) {
            return response()->json([
                'code' => 500,
                'msg' => 'The Column does not exist or you have a syntax error',
                'data' => $throw->getMessage()
            ], 500);
        }
    }



    public function addFavorite(Request $request){ 

        $user = $request->user();
        $bookId = $request->id;

        try {
                //create field in favorites table
            DB::table('favorites')->insertGetId([
                'status' => 1,
                'book_id' => $bookId,
                'user_token' => $user->token,
                'created_at' => Carbon::now()
            ]);

            $result = Favorite::select('status')
            ->where('book_id', '=', $bookId)
            ->where('user_token', '=', $user->token)
            ->first();
        
            return response()->json([
                'code' => 200,
                'msg' => 'My favorite status for this book is here',
                'data' => $result->status
            ], 200);
        } catch (\Throwable $throw) {
            return response()->json([
                'code' => 500,
                'msg' => 'The Column does not exist or you have a syntax error',
                'data' => $throw->getMessage()
            ], 500);
        }
    }




    public function updateFavorite(Request $request){ 

        $user = $request->user();
        $bookId = $request->id;

        try {
            $book_fav = Favorite::select('status')->where('book_id', '=', $bookId)->where('user_token', '=', $user->token)->first();

            //update favorite.status
            if($book_fav->status==0){
                $book_fav->status = 1;
            }else if($book_fav->status==1){
                $book_fav->status = 0;
            }

            Favorite::select('status')->where('book_id', '=', $bookId)->where('user_token', '=', $user->token)
            ->update(['status'=>$book_fav->status]);

            $result = Favorite::select('status')
            ->where('book_id', '=', $bookId)
            ->where('user_token', '=', $user->token)
            ->first();
        
            return response()->json([
                'code' => 200,
                'msg' => 'My favorite status for this book is here',
                'data' => $result->status
            ], 200);
        } catch (\Throwable $throw) {
            return response()->json([
                'code' => 500,
                'msg' => 'The Column does not exist or you have a syntax error',
                'data' => $throw->getMessage()
            ], 500);
        }
    }



    public function checkFavorite(Request $request){ 

        $user = $request->user();
        $bookId = $request->id;

        try {

            $result = Favorite::select('status')->where('book_id', '=', $bookId)->where('user_token', '=', $user->token)->first();
        
            if(!empty($result)){
                return response()->json([
                    'code' => 200,
                    'msg' => 'My favorite status for this book is here',
                    'data' => $result->status
                ], 200);               
            }else{
                return response()->json([
                    'code' => 200,
                    'msg' => 'My favorite status for this book is here',
                    'data' => null
                ], 200);
            }
        } catch (\Throwable $throw) {
            return response()->json([
                'code' => 500,
                'msg' => 'The Column does not exist or you have a syntax error',
                'data' => $throw->getMessage()
            ], 500);
        }
    }


}
