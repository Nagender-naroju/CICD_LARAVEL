<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
// use Illuminate\Http\Request;

class UserController extends Controller
{
    public function users()
    {
        $title = "Admin | Users Management";
        $users = User::paginate(10);
        return view('Admin.users', compact('title', 'users'));
    }
}
