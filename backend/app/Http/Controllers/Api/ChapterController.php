<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Chapter;
use App\Models\Book;

class ChapterController extends Controller {

    public function chapterList(Request $request){
        try{
            $bookId = $request->id;
            $result = Chapter::where('book_id', '=', $bookId)->select(
                'id',
                'name',
                'title',
                'subtitle',
                'text'
            )->get();

            return response()->json([
                'code' => 200,
                'data' => $result,
                'msg' => "success"
            ], 200);
        }catch(\Throwable $e){
            return response()->json([
                'code' => 200,
                'data' => "",
                'msg' => $e->getMessage()
            ], 500);
        }
    }

    public function chapterDetail(Request $request)
    {
        try {
            $chapterID = $request->id;
            $result = Chapter::where("id", "=", $chapterID)->first();;

            return response()->json([
                'code' => 200,
                'data' => $result,
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
}
