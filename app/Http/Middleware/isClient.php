<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class isClient
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next, $response = new \App\Helpers\Response)
    {
        if($request->user_type == 'client') {
            return $next($request);
        } else {
            return $response->notAuthorized('(Client resource) Access is not allowed!');
        }
    }
}
