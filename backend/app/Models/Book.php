<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Encore\Admin\Traits\DefaultDatetimeFormat;

class Book extends Model
{
    use HasFactory;
    use DefaultDatetimeFormat;

    protected $casts = [
        'media' => 'json',
    ];

       ////// movie trailer video
       public function setMediaAttribute($value){
        $newMedia = [];
        foreach($value as $k=>$v){
            $valueMedia = [];
            if(!empty($v['old_url'])){
                $valueMedia['url'] = $v['old_url'];
            }else{
                $valueMedia['url']=$v['url'];
            }

            if (!empty($v["old_thumbnail"])) {
                $valueMedia["thumbnail"] = $v["old_thumbnail"];
            } else {
                $valueMedia["thumbnail"] = $v["thumbnail"];
            }
            $valueMedia['name']=$v['name'];
            array_push($newMedia,$valueMedia);
        }
        //json_encode makes it json for the database
        //array_values get the values of the php associative array
        $this->attributes['media'] = json_encode(array_values($newMedia));
    }

    public function getMediaAttribute($value){
        //conver to associative array
        //    "key"=>"value",
        $result = json_decode($value, true);
        if(!empty($result)){
            foreach($result as $key => $value){
                $result[$key]['url'] = env('APP_URL')."uploads/".$value['url'];
                $result[$key]['thumbnail'] = env('APP_URL') . "uploads/" . $value['thumbnail'];
            }
        }
        return $result;
    }

    public function getThumbnailAttribute($value){
        return env('APP_URL')."uploads/".$value;
    }
}
