<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class MessageSent implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $message;
    public $from;
    public $to;
    public $user_type;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($message, $from, $to, $user_type)
    {
        $this->message = $message;
        $this->from = $from;
        $this->to = $to;
        $this->user_type = $user_type;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return \Illuminate\Broadcasting\Channel|array
     */
    public function broadcastOn()
    {
        // * channel name should be chat.[lawyer_id].[client_id]
        if ($this->user_type == 'lawyer')
            return ['chat.' . $this->from->id . '.' . $this->to->id];
        else
            return ['chat.' . $this->to->id . '.' . $this->from->id];
    }

    public function broadcastAs()
    {
        return 'binding';
    }
}
