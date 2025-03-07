<?php

namespace App\Http\Controllers\Api;

use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Stripe\Webhook;
use Stripe\Customer;
use Stripe\Price;
use Stripe\Stripe;
use Stripe\Checkout\Session;
use Stripe\Exception\UnexpectedValueException;
use Stripe\Exception\SignatureVerificationException;
use Illuminate\Support\Carbon;
use App\Models\Book;
use App\Models\Order;

class PayController extends Controller
{
    public function checkout(Request $request){

        try{
            $user = $request->user();
            $token = $user->token;
            $bookId = $request->id;

            // *Stripe api key* //

            Stripe::setApiKey('sk_test_51NjrINHFxgTmSJb2aNRy9tNKtZiCgaqmzuWYQsYcjQlAsr145TI0DD57L7c8AZVW8z7aYHNrfhILn3jV5UC4kUAN00Bygd1dVY');

            $bookResult = Book::where('id', '=', $bookId)->first();

            //invalid request
            if(empty($bookResult)){
                return response()->json([
                    'code'=> 400,
                    'msg'=> 'Book does not exist',
                    'data'=> ''
                ], 400);
            }

            $orderMap =[];

            $orderMap['book_id'] = $bookId;
            $orderMap['user_token'] = $token; //unique to each user
            $orderMap['status'] = 1; //0=not bough , 1=bought

            //if the order has been placed before or not => we need Order model&table
            $orderResult = Order::where($orderMap)->first();
            if(!empty($orderResult)){
                return response()->json([
                    'code'=> 400,
                    'msg'=> 'You have already bought this book',
                    'data'=> ""
                ]);
            }

            //new order for the user & submit
            $YOUR_DOMAIN = env('APP_URL');
            $map = [];
            $map['user_token'] = $token;
            $map['book_id'] = $bookId;
            $map['total_amount'] = $bookResult->price;
            $map['status'] = 0;
            $map['created_at'] = Carbon::now();
            $orderNum = Order::insertGetId($map);

            //create payment session
            $checkoutSession = Session::create(
                [
                    'line_items'=>[[
                        'price_data'=>[
                            'currency'=>'USD',
                            'product_data'=>[
                                'name'=>$bookResult->name,
                                'description'=>$bookResult->description,
                            ],
                            'unit_amount'=>intval(($bookResult->price)*100),
                        ],
                        'quantity'=>1,
                    ]],
                    'payment_intent_data'=>[
                        'metadata'=>['order_num'=>$orderNum, 'user_token'=>$token],
                    ],
                    'metadata' => ['order_num' => $orderNum, 'user_token' => $token],
                    'mode'=>'payment',
                    'success_url'=> $YOUR_DOMAIN . 'success',
                    'cancel_url'=> $YOUR_DOMAIN . 'cancel'
                ]
                );

            //return stripe url
            return response()->json([
                'code'=> 200,
                'msg'=> 'Success',
                'data'=> $checkoutSession->url
            ], 200);

        } catch(\Throwable $th){
            return response()->json([
                'error' => $th->getMessage(),
            ], 500);
        }
    }

public function web_go_hooks()
{
    Log::info("11211-------"); 
    Stripe::setApiKey('sk_test_51NjrINHFxgTmSJb2aNRy9tNKtZiCgaqmzuWYQsYcjQlAsr145TI0DD57L7c8AZVW8z7aYHNrfhILn3jV5UC4kUAN00Bygd1dVY');
    $endpoint_secret = 'whsec_iFOYJUs6G0xNvkNqC8M3bz2HxSUo9Z5z';
    $payload = @file_get_contents('php://input');
    $sig_header = $_SERVER['HTTP_STRIPE_SIGNATURE'];
    $event = null;
    Log::info("payload----" . $payload);

    try {
        $event = \Stripe\Webhook::constructEvent(
            $payload,
            $sig_header,
            $endpoint_secret
        );
    } catch (\UnexpectedValueException $e) {
        // Invalid payload
      //  Log::info("UnexpectedValueException" . $e);
        http_response_code(400);
        exit();
    } catch (\Stripe\Exception\SignatureVerificationException $e) {
        // Invalid signature
        Log::info("SignatureVerificationException" . $e);
        http_response_code(400);
        exit();
    }
    Log::info("event---->" . $event);

    //kur complete successful checkout
    // Handle the checkout.session.completed event
    if ($event->type == 'charge.succeeded') {
        $session = $event->data->object;
       // Log::info("event->data->object---->" . $session);
        $metadata = $session["metadata"];
        $order_num = $metadata->order_num;
        $user_token = $metadata->user_token;
      //  Log::info("order_id---->" . $order_num);
        $map = [];
        $map["status"] = 1; //update status ne database
        $map["updated_at"] = Carbon::now();
        $whereMap = [];
        $whereMap["user_token"] = $user_token;
        $whereMap["id"] = $order_num;
        Order::where($whereMap)->update($map);
    }


    http_response_code(200);
}

}