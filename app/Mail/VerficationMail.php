<?php

namespace App\Mail;

use App\Models\VerifyEmail;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Str;

class VerficationMail extends Mailable
{
    use Queueable, SerializesModels;

    private $user;
    private $token;
    private $user_type;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($user, $user_type, String $token)
    {
        $this->token = $token;
        $this->user = $user;
        $this->user_type = $user_type;
    }

    /**
     * Get the message envelope.
     *
     * @return \Illuminate\Mail\Mailables\Envelope
     */
    public function envelope()
    {
        return new Envelope(
            subject: 'Verfication Mail - Mowakly',
        );
    }

    /**
     * Get the message content definition.
     *
     * @return \Illuminate\Mail\Mailables\Content
     */
    public function content()
    {
        return new Content(
            view: 'mails.verify',
            with: ['name' => $this->user->fname, 'token' => $this->token, 'email' => $this->user->email, 'user_type' => $this->user_type],
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array
     */
    public function attachments()
    {
        return [];
    }
}
