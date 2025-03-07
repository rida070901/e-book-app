<?php

namespace App\Admin\Controllers;

use App\Models\User;
use App\Models\BookType;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;
use Encore\Admin\Layout\Content;
use Encore\Admin\Tree;

class BookTypeController extends AdminController
{

    //shows tree form of the menu
    public function index(Content $content){
        $tree = new Tree(new BookType); //take every info from BookType and show it in a tree
        return $content->header('Book Types')
        ->body($tree);
    }

    protected function detail($id) //just for view
    {
        $show = new Show(BookType::findOrFail($id)); //look in the db for the BookType by id, if found display the info below

        $show->field('id', __('Id'));
        $show->field('title', __('Category'));
        $show->field('description', __('Description'));
        $show->field('order', __('Order'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));

        return $show;
    }

    //creating and editing
    protected function form()
    {
        $form = new Form(new BookType());

        $form->select('parent_id', __('Parent Category'))
        ->options((new BookType())::selectOptions());
        $form->text('title', __('Title'));
       // $form->textarea('description', __('Description'));
        $form->number('order', __('Order'));

        return $form;
    }
}
