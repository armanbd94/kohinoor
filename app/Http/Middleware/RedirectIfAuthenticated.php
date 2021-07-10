<?php

namespace App\Http\Middleware;

use App\Providers\RouteServiceProvider;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RedirectIfAuthenticated
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string|null  ...$guards
     * @return mixed
     */
    public function handle($request, Closure $next, $guard = null)
    {
        if ($guard == "asm" && Auth::guard($guard)->check()) {
            return redirect('asm/dashboard');
        }
        if (Auth::guard($guard)->check()) {
            return redirect('/');
        }

        return $next($request);
    }
    // public function handle($request, Closure $next, $guard = null)
    // {
    //     switch($guard){
    //         case 'asm':
    //             if (Auth::guard($guard)->check()) {
    //                 return redirect('asm/dashboard');
    //             }
    //             break;
    //         default:
    //             if (Auth::guard($guard)->check()) {
    //                 return redirect('/');
    //             }
    //             break;
    //     }
    //     return $next($request);
    // }
    
}
