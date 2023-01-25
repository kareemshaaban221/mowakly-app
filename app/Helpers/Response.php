<?php

namespace App\Helpers;

Class Response
{
    public function ok(array $data) {
        $data['status'] = 200;
        return response()->json($data, 200);
    }

    public function notAuthorized($msg) {
        return response()->json([
            'message' => $msg,
            'status' => 401
        ], 401);
    }

    public function badRequest($msg, $err = NULL) {
        if($err) {
            return response()->json([
                'errors' => $err,
                'message' => $msg,
                'status' => 400
            ], 400);
        }
        else {
            return response()->json([
                'message' => $msg,
                'status' => 400
            ], 400);
        }
    }

    public function created($data, $createdObj, $msg = NULL) {
        $data['message'] = $msg ? $msg : ucwords($createdObj) . ' has been created successfully!';
        $data['status'] = 201;

        return response()->json($data, 201);
    }
}
