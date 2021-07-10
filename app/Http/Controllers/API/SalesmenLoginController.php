<?php

namespace App\Http\Controllers\API;


use Validator;
use JWTAuthException;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class SalesmenLoginController extends Controller
{
    public function __construct()
    {
        Auth::shouldUse('salesmen-api');
    }

    protected function sendResult($message,$data = [],$errors = [],$status = true)
    {
        $result = [
            "status" => $status,
            "data" => $data,
            "message" => $message,
            "errors" => $errors
        ];
        return response()->json($result);
    }

    public function login(Request $request)
    {
        $errors  = [];
        $data    = [];
        $message = "";
        $status  = true;

        $validator = Validator::make($request->all(), [
            'username' => 'required|string|max:30',
            'password' => 'required|string|min:8',
        ]);

        if ($validator->fails()) {
            $status = false;
            $errors = $validator->errors();
            $message = "Login Failed";
            return $this->sendResult($message,$data,$errors,$status);
        }
		$token = null;
		try {
		    if (!$token = JWTAuth::attempt($validator->validated())) {
                $status = false;
                $errors = [
                    "login" => "Invalid username or password",
                ];
                $message = "Login Failed";
		    }else{
                $message = "Login Successfull";
                $data = [
                    'access_token' => $token,
                    'token_type' => 'bearer',
                    'expires_in' => auth()->factory()->getTTL(),
                    'user' => auth()->user(),
                ];
            }
		} catch (JWTAuthException $e) {
            $status = false;
		    $message = 'Failed to create token';
        }
        return $this->sendResult($message,$data,$errors,$status);
		// return $this->createNewToken($token);
    }

    public function salesmenProfile()
    {
        return response()->json(auth()->user());
    }

    
    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh() {
        return $this->createNewToken(auth()->refresh());
    }

    

}
