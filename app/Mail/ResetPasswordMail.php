<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class ResetPasswordMail extends Mailable
{
    use Queueable, SerializesModels;

    private $user;
    private $code;
    private $remain;

    // private $user_type;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($user, String $code, $remain)
    {
        $this->code = $code;
        $this->user = $user;
        $this->remain = $remain;
    }

    /**
     * Get the message envelope.
     *
     * @return \Illuminate\Mail\Mailables\Envelope
     */
    public function envelope()
    {
        return new Envelope(
            subject: 'Reset Password Mail - Mowakly',
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
            view: 'mails.reset_password',
            with: [
                'name' => $this->user->fname,
                'code' => $this->code,
                'remain' => $this->remain,
                // 'email' => $this->user->email,
                // 'user_type' => $this->user_type
            ],
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
