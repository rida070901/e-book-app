<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Book;
use App\Models\Order;
use App\Models\BookType;
use Illuminate\Support\Facades\DB;


class BookController extends Controller
{


    //return all the book list
    public function bookList(){
        try {
            // select the fields we need from Book table in db 
            $result = Book::select('name', 'thumbnail', 'page_num', 'price', 'type_id', 'id')
            ->inRandomOrder()
            ->get(); //returns a collection of objects
        
            return response()->json([
                'code' => 200,
                'msg' => 'My book list is here',
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



    public function fromCheapestList(){
        try {
            $result = Book::select('name', 'thumbnail', 'page_num', 'price', 'type_id', 'id')
            ->orderBy('price', 'asc')
            ->get();
        
            return response()->json([
                'code' => 200,
                'msg' => 'My book list is here',
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




        // return books details
        public function BookDetail(Request $request){ //request has data from http/post request from the booklist up
            //book id
            $id = $request->id; //is inside $request, from frontend (kur kalojm nga homepage(click on one book from bookGrid) ne book detail page)

            try {
                $result = Book::where('books.id', '=', $id)
                ->join('book_types', 'books.type_id', '=', 'book_types.id')
                ->join('admin_users', 'books.user_token', '=', 'admin_users.token')
                ->select('books.id', 'books.name','books.user_token', 'books.description', 'books.page_num', 'books.thumbnail', 'books.language', 'books.first_published_date', 'books.price', 'book_types.title', 'admin_users.name as author_name')
                ->first();
            
                return response()->json([
                    'code' => 200,
                    'msg' => 'My book details are here',
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




        public function trailerDetail(Request $request) {
            try {
                $id = $request->id;
                $result = Book::where("id", "=", $id)->first();;
    
                return response()->json([
                    'code' => 200,
                    'data' => $result->media,
                    'msg' => "success"
                ], 200);
            } catch (\Throwable $e) {
                return response()->json([
                    'code' => 200,
                    'data' => "",
                    'msg' => $e->getMessage()
                ], 500);
            }
        }




        public function booksBought(Request $request){ 
            //first get the user info
            $user = $request->user(); //from middleware

            $result = Book::join('orders', 'books.id', '=', 'orders.book_id')
            ->select('books.name', 'books.thumbnail', 'books.page_num', 'books.price', 'books.id')
            ->where('orders.status', '=', '1')
            ->where('orders.user_token', '=', $user->token)
            ->get();

            try {
                return response()->json([
                    'code' => 200,
                    'msg' => 'My book details are here',
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


        

        public function bookBought(Request $request){ 
            try {

                $orderMap =[];

                $orderMap['book_id'] = $request->id;
                $orderMap['user_token'] = $request->user()->token; //unique to each user
                $orderMap['status'] = 1; //0=not bough , 1=bought
    
                //if the order has been placed before or not => we need Order model&table
                $orderRes = Order::where($orderMap)->first();

                if(!empty($orderRes)){
                    return response()->json([
                        'code' => 200,
                        'msg' => "success",
                        'data' => ""
                    ], );
                }else{
                    //item not bought
                    return response()->json([
                        'code' => 200,
                        'msg' => "failure",
                        'data' => ""
                    ], );
                }

            } catch (\Throwable $throw) {
                return response()->json([
                    'code' => 500,
                    'msg' => 'The Column does not exist or you have a syntax error',
                    'data' => $throw->getMessage()
                ], 500);
            }
        }




        public function orderList(Request $request){ 
            //first get the user info
            $user = $request->user(); //from middleware

            $result = Book::join('orders', 'books.id', '=', 'orders.book_id')
            ->select('books.name', 'books.thumbnail', 'books.page_num', 'books.price', 'books.id', 'orders.status')
            //->where('orders.status', '=', '1')
            ->where('orders.user_token', '=', $user->token)
            ->get();

            try {
                return response()->json([
                    'code' => 200,
                    'msg' => 'My order list is here',
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




        //return all the recommended book list
        public function recommendedBookList(){
            try {
                // select the fields we need from Book table in db 
                $result = Book::select('name', 'thumbnail', 'page_num', 'price', 'id')
                ->where('recommended', '=', 1)
                ->orderBy('created_at', 'desc')
                ->get(); //returns a collection of objects
            
                return response()->json([
                    'code' => 200,
                    'msg' => 'My recommended book list is here',
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



        public function newBooksList(){
            try {
                $result = Book::select('name', 'thumbnail', 'page_num', 'price', 'id')->latest()->take(4)
                ->get();

                return response()->json([
                    'code' => 200,
                    'msg' => 'My book list is here',
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






        //return all the searched book list
        public function searchBookList(Request $request){

            $search = $request->search;

            try {
                // select the fields we need from Book table in db 
                // $result = Book::select('name', 'thumbnail', 'page_num', 'price', 'id')
                // ->where('name', 'like', '%'.$search.'%')
                // ->get(); //returns a collection of objects

                $result = Book::join('admin_users', 'books.user_token', '=', 'admin_users.token')
                ->select('books.name', 'books.thumbnail', 'books.page_num', 'books.price', 'books.id')
                ->where('books.name', 'like', '%'.$search.'%')
                ->orWhere('admin_users.name', 'like', '%'.$search.'%')
                ->get(); 

            
                return response()->json([
                    'code' => 200,
                    'msg' => 'My searched book list is here',
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




        // author profile page api
        function bookAuthor(Request $request){
            try {
                $token = $request->token;
                $result = DB::table('admin_users')->where('token', '=', $token)
                ->select('token', 'username as name', 'avatar', 'description', 'bg_image', 'download')->first();
                if(!empty($result)){
                $result->avatar = env('APP_URL').'uploads/'.$result->avatar;
                }
                return response()->json([
                    'code' => 200,
                    'msg' => 'My author profile is here',
                    'data' => $result??json_decode('{}')
                ], 200);
            } catch (\Throwable $throw) {
                return response()->json([
                    'code' => 500,
                    'msg' => 'The Column does not exist or you have a syntax error',
                    'data' => $throw->getMessage()
                ], 500);
            }
        }




        function bookListAuthor(Request $request){
            try {
                $token = $request->token;
                $result = Book::where('user_token', '=', $token)
                ->select('name', 'thumbnail', 'page_num', 'price', 'id')->get();

                return response()->json([
                    'code' => 200,
                    'msg' => 'My authors book list is here',
                    'data' => $result??json_decode('{}')
                ], 200);
            } catch (\Throwable $throw) {
                return response()->json([
                    'code' => 500,
                    'msg' => 'The Column does not exist or you have a syntax error',
                    'data' => $throw->getMessage()
                ], 500);
            }
        }






}
