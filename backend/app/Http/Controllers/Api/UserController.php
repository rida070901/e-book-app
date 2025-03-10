<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    /**
     * Create User
     * @param Request $request
     * @return User 
     */
    public function createUser(Request $request)
    {
        try {
            //Validated
            $validateUser = Validator::make($request->all(), 
            [
                'avatar' => 'required',
                'type' => 'required',
                'open_id' => 'required',
                'name' => 'required',
                'email' => 'required',
                //'password' => 'required|min:6'
            ]);

            if($validateUser->fails()){
                return response()->json([
                    'status' => false,
                    'message' => 'validation error',
                    'errors' => $validateUser->errors()
                ], 401);
            }

            //validated will have all user field value, we can save in the database
            $validated = $validateUser->validated();

            $map=[];
            $map['type']=$validated['type'];
            $map['open_id']=$validated['open_id'];

            $user = User::where($map)->first();          

            //whether the user has logged in or not
            //if empty --> does not exist => then save the user in the Database for the first time
            if(empty($user->id)) {                

                //this certain user has never been in our database
                //we need to asign this user in the database

                //this token is the user id --> so that "hackers" do not guess our id's
                $validated["token"] = md5(uniqid().rand(10000, 99999));
                //user first time created
                $validated['created_at'] = Carbon::now();

                // // --------- DEBUG -----------
                // return response()->json([
                //     'status' => true,
                //     'data' => $validated,
                //     'message' => "passed validation"
                // ], 200);     
                                
                //encrypt password
                //$validated['password'] = Hash::make($validated['password']);
                
                //returns the id of the row after saving
                $userID = User::insertGetId($validated);
                //users all info
                $userInfo = User::where('id', '=', $userID)->first();

                //every time a user logs in he will have a different token --> secure communication
                $accessToken = $userInfo->createToken(uniqid())->plainTextToken;
                $userInfo->access_token = $accessToken;
                User::where('id', '=', $userID)->update(['access_token'=>$accessToken]);

                return response()->json([
                    'code' => 200,
                    'msg' => 'User Created Successfully',
                    'data' => $userInfo
                ], 200);
            }         

            //users that have alrd logged in before
            $accessToken = $user->createToken(uniqid())->plainTextToken;
            $user->access_token = $accessToken;
            User::where('open_id', '=', $validated['open_id'])->update(['access_token'=>$accessToken]);


            return response()->json([
                'code' => 200,
                'msg' => 'User Logged In Successfully',
                'data' => $user
            ], 200);

        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }

    /**
     * Login The User
     * @param Request $request
     * @return User
     */
    public function loginUser(Request $request)
    {
        try {
            $validateUser = Validator::make($request->all(), 
            [
                'email' => 'required|email',
                'password' => 'required'
            ]);

            if($validateUser->fails()){
                return response()->json([
                    'status' => false,
                    'message' => 'validation error',
                    'errors' => $validateUser->errors()
                ], 401);
            }

            if(!Auth::attempt($request->only(['email', 'password']))){
                return response()->json([
                    'status' => false,
                    'message' => 'Email & Password does not match with our record.',
                ], 401);
            }

            $user = User::where('email', $request->email)->first();

            return response()->json([
                'status' => true,
                'message' => 'User Logged In Successfully',
                'token' => $user->createToken("API TOKEN")->plainTextToken
            ], 200);

        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }
    }
}