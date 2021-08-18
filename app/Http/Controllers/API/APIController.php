<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class APIController extends Controller
{
    public function sendResult($message,$data = [],$errors = [],$status = true)
    {
        $result = [
            "status" => $status,
            "data" => $data,
            "message" => $message,
            "errors" => $errors
        ];
        return response()->json($result);
    }
}
