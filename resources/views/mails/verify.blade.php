Dear {{ucwords($name)}},<br/>
Verify your email in Mowakly app to be served correctly.<br/>
<br/>
Link:
@if (request()->user_type == 'lawyer')
    <a href="{{url(route('lawyer.email.verify', ['token' => $token])) . '?email=' . $email . '&user_type=lawyer'}}">Verify Now</a>
@else
    <a href="{{url(route('client.email.verify', ['token' => $token])) . '?email=' . $email . '&user_type=client'}}">Verify Now</a>
@endif
<br/>
<br/>
<b>Mowakly app</b><br/>
