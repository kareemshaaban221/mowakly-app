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

    public function forbidden($msg) {
        return response()->json([
            'message' => $msg,
            'status' => 403
        ], 403);
    }

    public function notFound($msg = NULL, $obj = NULL) {
        if(!$msg) {
            if(!$obj) {
                $msg = 'Not found';
            }
            $msg = 'This '. $obj .' is not found!';
        }

        return response()->json([
            'message' => $msg,
            'status' => 404,
        ], 404);
    }
}
