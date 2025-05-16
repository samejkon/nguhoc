<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>

<body>
    <div class="container mt-5">
        <h2>Please verify your email address</h2>
        <p>
            A verification link has been sent to your email. <br>
            If you didn’t receive it, click the button below to request another.
        </p>
        @if (session('message'))
            <div class="alert alert-success mt-2">{{ session('message') }}</div>
        @endif
        <form method="POST" action="{{ route('verification.send') }}">
            @csrf
            <button type="submit" class="btn btn-primary mt-3">Resend Verification Email</button>
        </form>
    </div>
</body>

</html>
