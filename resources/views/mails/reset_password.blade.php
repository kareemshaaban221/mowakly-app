Dear {{ucwords($name)}},<br/>
This mail is about resetting your password in Mowakly app.<br/>
<br/>
Please visit this link:
@if (request()->user_type == 'lawyer')
    <a href="{{url(route('lawyer.password.reset', ['token' => $token])) . '?email=' . $email . '&user_type=lawyer'}}">Reset Password</a>
@else
    <a href="{{url(route('client.password.reset', ['token' => $token])) . '?email=' . $email . '&user_type=client'}}">Reset Password</a>
@endif
<br/>
<br/>
NOTE: Just you visit the mentioned link, you can NOT access it again.<br/>
<br/>
<br/>
<b>Mowakly app</b><br/>
