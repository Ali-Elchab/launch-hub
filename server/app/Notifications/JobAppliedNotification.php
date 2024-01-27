<?php

namespace App\Notifications;

use Illuminate\Notifications\Notification;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification as FCMNotification;

class JobAppliedNotification extends Notification
{
    private $details;

    public function __construct($details)
    {
        $this->details = $details;
    }

    public function via($notifiable)
    {
        return ['firebase'];
    }

    public function toFirebase($notifiable)
    {
        $messaging = app('firebase.messaging');
        $title = 'New Job Application';
        $body = $this->details['message'];

        $message = CloudMessage::withTarget('token', $notifiable->fcm_token)
            ->withNotification(FCMNotification::create($title, $body));

        return $messaging->send($message);
    }
}
