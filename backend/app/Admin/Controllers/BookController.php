<?php

namespace App\Admin\Controllers;

use App\Models\User;
use App\Models\Book;
use App\Models\BookType;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;
use Encore\Admin\Layout\Content;
use Encore\Admin\Tree;
use Encore\Admin\Facades\Admin;
use Illuminate\Support\Facades\DB;

class BookController extends AdminController
{
    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid() //show in Book List Column
    {
        $grid = new Grid(new Book());
        $grid->column('id', __('Id'));

        //authenticate users
        if(Admin::user()->isRole('author')){
            $token = Admin::user()->token;
            $grid->model()->where('user_token', '=', $token);
        }
        
        $grid->column('user_token', __('Author'))->display(function ($token){
           //return User::where('token', '=', $token)->value('name');
           $item = DB::table('admin_users')->where('token', '=', $token)->value('username');
           return $item;
        });
        if(Admin::user()->isRole('administrator')){
            $grid->column('recommended', __('Recommended'))->switch();
        }
        $grid->column('name', __('Name'));
        $grid->column('thumbnail', __('Thumbnail'))->image('', 50, 50);
        //$grid->column('description', __('Description'));
        $grid->column('type_id', __('Type id'));
        $grid->column('price', __('Price'));
        $grid->column('page_num', __('Number of pages'));
        $grid->column('created_at', __('Created at'));

        return $grid;
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     * @return Show
     */
    protected function detail($id)
    {
        $show = new Show(Book::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('name', __('Name'));
        $show->field('thumbnail', __('Cover'));
        $show->field('description', __('Description'));
        $show->field('price', __('Price'));
        $show->field('page_num', __('Number of pages'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));

        return $show;
    }

    protected function form()   //creating and editing
    {
        $form = new Form(new Book());
        $form->text('name', __('Name'));

        //get our categories
        $result = BookType::pluck('title', 'id');
        $form->select('type_id', __('Category'))->options($result);

        $form->image('thumbnail', __('Cover'))->uniqueName();
        //file is used for video and other format like pdf/doc
        $form->textarea('description', __('Description'));
        //decimal method helps with retrieving float format from the database
        $form->decimal('price', __('Price'));
        $form->number('page_num', __('Number of pages'));
        $form->text('language', __('Language'));
        $form->date('first_published_date', __('Publication Date'));

        $form->display('created_at', __('Created at'));
        $form->display('updated_at', __('Updated at'));

        if($form->isEditing()){
            //dump($form->media);
            //$form->text('media', __('Media'));
            $form->table('media', function($form){
                $form->text('name');
                $form->hidden('old_url');
                $form->hidden('old_thumbnail');
                $form->image('thumbnail')->uniqueName();
                $form->file('url');
            });
        }else{
            //$form->text('media', __('Media'));
            $form->table('media', function($form){
                $form->text('name')->rules('required');
                $form->image('thumbnail')->uniqueName()->rules('required');
                $form->file('url')->rules('required');
            });
        }

        // saving call back gets called before submitting to the database
        // but after clicking the submit button
        // a good place to process grabbed data or form data
        $form->saving(function (Form $form){
            if($form->isEditing()){
                 //here is the place to process data and
                 //the below one gets the editted data
                 $media = $form->media;
                 // the below gets data from the database
                 $res = $form->model()->media;
                 //for each of the key, get the value
                 $path = env('APP_URL') . "uploads/";
 
                 $newMedia = [];
                 foreach ($media as $k => $v) {
                     $oldMedia = [];
                     //user did not type anything
                     if (empty($v['url'])) {
                         $oldMedia["old_url"] = empty($res[$k]['url']) ? ""
                             //replacing the domian path from the value
                             : str_replace($path, "", $res[$k]['url']);
                     } else {
                         //this is a new editted value
                         $oldMedia["url"] = $v['url'];
                     }
 
                     if (empty($v['thumbnail'])) {
                         $oldMedia["old_thumbnail"] = empty($res[$k]['thumbnail']) ? ""
                             //replacing the domian path from the value
                             : str_replace($path, "", $res[$k]['thumbnail']);
                     } else {
                         //this is a new editted value
                         $oldMedia["thumbnail"] = $v['thumbnail'];
                     }
 
                     if (empty($v['name'])) {
                         $oldMedia["name"] = empty($res[$k]['name']) ? ""
 
                             :  $res[$k]['name'];
                     } else {
                         //this is a new editted value
                         $oldMedia["name"] = $v['name'];
                     }
 
                     $oldMedia['_remove_']=$v['_remove_'];
                     array_push($newMedia, $oldMedia);
                    // dump($newMedia);
                 }
                 $form->media = $newMedia;
            }
 
         });


        //for the posting, who is posting
        //$result = User::pluck('name', 'token');
        //$form->select('user_token', __('Author'))->options($result);


        if(Admin::user()->isRole('author')){
            $token = Admin::user()->token;
            $userName = Admin::user()->username;
            $form->select('user_token', __('Author'))->options([$token=>$userName])->default($token)->readonly();
        }else{
            $res = DB::table('admin_users')->pluck('username', 'token');
            $form->select('user_token', __('Author'))->options($res);
        }


        if(Admin::user()->isRole('author')){
            $form->switch('recommended', __('Recommended'))->default(0)->readonly();
        }else{
            $form->switch('recommended', __('Recommended'))->default(0);
        }


        return $form;
    }
}
