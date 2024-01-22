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
        $messages = $user->messages;
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

            $prompt = "I am an AI assistant providing specific advice to startups. ";
            $prompt .= "I specialize in offering guidance based on the startup's profile and the nature of the inquiries. ";
            $prompt .= "Here are the details of the startup I am assisting: ";
            $prompt .= "Industry: $industry, Specialization: $specialization, Company Name: $company, ";
            $prompt .= "Description: $description, Founding Date: $foundingDate, Location: $address. ";
            $prompt .= "I need to provide concise, relevant, and practical advice based on the inquiries made. ";
            $prompt .= "For short or unclear questions, I should ask for clarification to give the best possible response. ";
            $prompt .= "Question: $message->text. ";
            $prompt .= "Response should be in plain text, focused, and directly related to the startup's context. ";
            if (strlen(trim($message->text)) < 3) {
                $prompt = "return this as plain text: The question seems too short. Could you please provide more details or specify your query?";
            }
        }
        if ($user->jobSeeker) {
            $jobSeeker = $user->jobSeeker;
            $name = $jobSeeker->first_name . ' ' . $jobSeeker->last_name;
            $dob = $jobSeeker->dob;
            $bio = $jobSeeker->bio;
            $address = $jobSeeker->address;
            $industry = $jobSeeker->industry->name;
            $specialization = $jobSeeker->specialization->name;
            $prompt = "I am an AI assistant providing career and professional advice to individuals. ";
            $prompt .= "I specialize in offering personalized guidance based on each person's professional background and their specific questions. ";
            $prompt .= "Here are the details of the individual seeking advice: ";
            $prompt .= "Name: $name, Industry: $industry, Specialization: $specialization, Date of Birth: $dob, ";
            $prompt .= "Professional Biography: $bio, Location: $address. ";
            $prompt .= "The individual is seeking advice on the following: $message->text. ";
            $prompt .= "My response should be in plain text, directly addressing the individual's query, and tailored to their professional background. ";
            $prompt .= "In case the query is unclear or too general, I should ask for more specific details to provide the most helpful response. ";
            if (strlen(trim($message->text)) < 3) {
                $prompt = "return this as plain text: The question seems too short. Could you please provide more details or specify your query?";
            }
        }

        $result = OpenAI::completions()->create([
            'model' => 'gpt-3.5-turbo-instruct',
            'prompt' => $prompt,
            'max_tokens' => 3700,
        ]);

        $response = ltrim($result['choices'][0]['text'], "\n");

        $aiMessage = new Message();
        $aiMessage->text = $response;
        $aiMessage->user_id = $user->id;
        $aiMessage->sender = 'bot';
        $aiMessage->save();

        return response()->json($aiMessage);
    }

    public function clearMessages()
    {
        $user = auth()->user();
        $messages = $user->messages;
        foreach ($messages as $message) {
            $message->delete();
        }
        return response()->json(['status' => 'success', 'message' => 'Messages cleared successfully']);
    }
}
