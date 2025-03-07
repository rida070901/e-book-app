<?php

namespace App\Admin\Controllers;

use App\Models\Chapter;
use App\Models\Book;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;
use Encore\Admin\Facades\Admin;
use Illuminate\Support\Facades\DB;

class ChapterController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Chapter';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Chapter());

        $grid->column('id', __('Id'));

        if(Admin::user()->isRole('author')){
            $token = Admin::user()->token;
            $ids = DB::table('books')->where('user_token', '=', $token)
            ->pluck('id')
            ->toArray();
            $grid->model()->whereIn('book_id', $ids);
        }

        $grid->column('book_id', __('Book id'));
        $grid->column('name', __('Chapter Name'));
        $grid->column('title', __('Title'));
        $grid->column('subtitle', __('Subtitle'));
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));

        //$grid->disableActions();

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
        $show = new Show(Chapter::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('book_id', __('Book id'));
        $show->field('name', __('Name'));
        $show->field('title', __('Title'));
        $show->field('subtitle', __('Subtitle'));
        $show->field('text', __('Text'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new Chapter());

        $form->text('name', __('Chapter Name'));

        if(Admin::user()->isRole('author')){
            $token = Admin::user()->token;
            $ids = DB::table('books')->where('user_token', '=', $token)->pluck('name' ,'id');
            $form->select('book_id', __("Books"))->options($ids);
        }else{
            $res = DB::table('books')->pluck('name', 'id');
            $form->select('book_id', __('Books'))->options($res);
        }

        $form->text('title', __('Title'));
        $form->text('subtitle', __('Subtitle'));
        $form->textarea('text', __('Text'));

        return $form;
    }
}
