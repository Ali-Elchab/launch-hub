<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Events\NewMessage;
use App\Models\Message;
use App\Models\User;
use OpenAI\Laravel\Facades\OpenAI;

class MessageController extends Controller
{
    public function getUserMessages()
    {
        $user = auth()->user();
        $messages = $user->messages->sortByDesc('created_at');
        return response()->json($messages);
    }

    public function sendMessage(Request $request)
    {
        $validatedData = $request->validate([
            'text' => 'required|string',
        ]);
        $user = User::find(auth()->user()->id);
        $message = new Message();
        $message->text = $validatedData['text'];
        $message->sender = 'user';
        $message->user_id = $user->id;
        $message->save();

        if ($user->startup) {
            $startup = $user->startup;
            $company = $startup->company_name;
            $description = $startup->company_description;
            $foundingDate = $startup->founding_date;
            $address = $startup->company_address;
            $industry = $startup->industry->name;
            $specialization = $startup->specialization->name;

            $prompt = "\n I started a startup company in the $industry industry, $specialization niche, my company name is $company, ";
            $prompt .= "\nthe company's description is the following $description, ";
            $prompt .= "\nthe company founding date is $foundingDate, ";
            $prompt .= "\nlocated in $address, ";
            $prompt .= "\n I am seeking help with the following: ";
            $prompt .= "\n $message->text.";
            $prompt .= "\n Please return as plain text, dont add anything before or after the answer";
        }
        if ($user->jobSeeker) {
            $jobSeeker = $user->jobSeeker;
            $name = $jobSeeker->first_name . ' ' . $jobSeeker->last_name;
            $dob = $jobSeeker->dob;
            $bio = $jobSeeker->bio;
            $address = $jobSeeker->address;
            $industry = $jobSeeker->industry->name;
            $specialization = $jobSeeker->specialization->name;

            $prompt = "\n My name is $name I am a job seeker in the $industry industry, specializing in $specialization, I was born in $dob.";
            $prompt .= "\nhere is my professional biography: $bio";
            $prompt .= "\ni am located in $address, ";
            $prompt .= "\n I am seeking ai assistance with the following: ";
            $prompt .= "\n $message->text.";
            $prompt .= "\n Please return as plain text, dont add anything before or after the answer";
        }

        $result = OpenAI::completions()->create([
            'model' => 'gpt-3.5-turbo-instruct',
            'prompt' => $prompt,
            'max_tokens' => 3700,
        ]);

        $response = $result['choices'][0]['text'];

        $aiMessage = new Message();
        $aiMessage->text = $response;
        $aiMessage->user_id = $user->id;
        $aiMessage->sender = 'bot';
        $aiMessage->save();

        return response($response, 200);
    }
}
