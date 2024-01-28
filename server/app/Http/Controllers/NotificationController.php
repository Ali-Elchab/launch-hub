<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class NotificationController extends Controller
{

    public function sendNotifications(Request $request)
    {
        $serverKey = env('FIREBASE_SERVER_KEY');

        $curl = curl_init();
        $registrationIds = $request->input('registration_ids');
        $applicant = $request->applicant;
        $jobPost = $request->jobPost;
        curl_setopt_array($curl, array(
            CURLOPT_URL => 'https://fcm.googleapis.com/fcm/send',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => json_encode([
                'registration_ids' => $registrationIds,
                'notification' => [
                    'body' =>  "{$applicant} has applied for your job post {$jobPost}",
                    'title' => 'New Application',
                    'name' => `$applicant have applied for your job post $jobPost`,
                    "da" => "this is a console data",
                    "clickUrl" => "https://google.com"
                ]
            ]),



            CURLOPT_HTTPHEADER => array(
                'Accept: application/json, text/plain, */*',
                'Authorization: key=' . $serverKey,
                'Content-Type: application/json'
            ),
        ));

        $response = curl_exec($curl);

        curl_close($curl);
        echo $response;
    }
}
