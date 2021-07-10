<?php

namespace Modules\ASM\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;
use Illuminate\Foundation\Auth\ThrottlesLogins;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use App\Http\Controllers\Controller;

class LoginController extends Controller
{
    use ThrottlesLogins;

    /**
     * Where to redirect admins after login.
     *
     * @var string
     */
    protected $redirectTo = 'asm/dashboard';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest:asm')->except('logout');
    }

    /**
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function showLoginForm()
    {
        return view('asm::auth.login');
    }

    public function login(Request $request)
    {
        $this->validate($request, [
            'username'   => 'required|string|max:30',
            'password' => 'required|string|min:8|max:30'
        ]);

        if (Auth::guard('asm')->attempt(['username' => $request->username, 'password' => $request->password], $request->get('remember'))) {
            if(Auth::guard('asm')->user()->status == 2){
                $this->guard()->logout();
                session()->flash('error', 'You account is disabled. Please contact with admin to enable account.');
                return redirect('asm/login');
            }else{
                return redirect()->intended('asm/dashboard')->with('message','Welcome Back');
            }
        }
        return back()->withInput($request->only('username', 'remember'))->with('error','Invalid username or password');
    }

    protected function guard()
    {
        return Auth::guard('asm');
    }


    public function logout(Request $request)
    {
        $this->guard()->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect('asm/login');
    
    }
    
    public function redirectPath()
    {
        return property_exists($this, 'redirectTo') ? $this->redirectTo : 'asm/login';
    }
}
