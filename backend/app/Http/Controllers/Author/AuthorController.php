<?php

namespace App\Http\Controllers\Author;

use App\Models\AdminUser;
use Illuminate\Support\Carbon;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AuthorController extends Controller
{
    public function login(Request $request){

        try{

            $validateUser = Validator::make($request->all(), 
            [
                'username' => 'required',
                'password' => 'required'
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
            $map['username']=$validated['username'];

            $user = AdminUser::where($map)->first();

            if(empty($user->id)){
                
                return response()->json([
                    'code' => 400,
                    'msg' => 'user doesnt exist',
                    'data' => ''
                ], 400);
            }

            if(!Hash::check($validated['password'], $user->password)){

                return response()->json([
                    'code' => 403,
                    'msg' => 'password incorrect',
                    'data' => ''
                ], 200);
            }

            $accessToken = $user->createToken(uniqid())->plainTextToken;
            $user->access_token = $accessToken;

            return response()->json([
                'code' => 200,
                'msg' => 'user found',
                'data' => $user
            ], 200);

        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'message' => $th->getMessage()
            ], 500);
        }

    }
}
